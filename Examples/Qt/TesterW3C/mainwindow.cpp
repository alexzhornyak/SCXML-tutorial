#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QDir>
#include <QBitmap>
#include <QLoggingCategory>
#include <QFileDialog>
#include <QSettings>
#include <QDomDocument>
#include <QDirIterator>

enum {
    testRolesSpecial = Qt::UserRole,
    testRolesState,
    testRolesPath,
    testRolesDescription
};

static MainWindow * g_MainWindow = nullptr;

//---------------------------------------------------------------------------
QPixmap ConvertBmpWithAlpha(const QString &sPath) {
    QImage img(sPath);
    img.setAlphaChannel(img.createMaskFromColor(img.pixel(0,0), Qt::MaskOutColor));
    return QPixmap::fromImage(img);
}

//---------------------------------------------------------------------------
//------------------------------- MainWindow --------------------------------
//---------------------------------------------------------------------------
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    this->setWindowTitle("Qt SCXML Tester by Alex Zhornyak");

    ui->setupUi(this);

    for (int i=0; i < MainWindow::tsMAXSIZE; i++) {
        _icon[i] = ConvertBmpWithAlpha(":/Res/img" + QString::number(i*2) + ".bmp");
    }

    {
        QFile file(":/Res/ScxmlLinks.ini");
        if (file.open(QIODevice::ReadOnly | QIODevice::Text))
        {
            QTextStream in(&file);
            while (!in.atEnd()) {
                auto links = in.readLine().split("=");
                if (links.size()==2) {
                    _scxmlLinks.insert(links[0], links[1]);
                }
            }
            file.close();
        }
    }

    {
        QFile file(":/Res/MarkdownCodeRegs.txt");
        if (file.open(QIODevice::ReadOnly | QIODevice::Text))
        {
            QStringList codeRegs;
            QTextStream in(&file);
            while (!in.atEnd()) {
                const QString codeReg = in.readLine().trimmed();
                if (!codeReg.isEmpty())
                    codeRegs << ( "(" + codeReg + ")" );
            }
            file.close();

            _markdownCodeRegs = codeRegs.join("|");
        }
    }

    _appMachine = new ScxmlW3CTester(this);
    _monitor = new Scxmlmonitor::UDPScxmlExternMonitor(_appMachine);

    ui->frameFolder->setVisible(true);
    _appMachine->connectToState("setupDirectory", [this](bool active){
        ui->frameFolder->setVisible(active);
        if (active) {
            setupDirectory();
        }
    });

    ui->frameCommands->setVisible(false);
    ui->progressBar->setVisible(false);
    _appMachine->connectToState("testerActive", [this](bool active){
        ui->progressBar->setVisible(active);
        ui->frameCommands->setVisible(active);
    });

    ui->btnReset->setEnabled(false);
    ui->btnStart->setEnabled(false);
    ui->btnReport->setVisible(false);
    _appMachine->connectToState("testerStopped", [this](bool active){
        ui->frameFolder->setVisible(active);
        ui->btnReset->setEnabled(active);
        ui->btnStart->setEnabled(active);
        ui->btnReport->setVisible(active);
    });

    ui->btnStop->setEnabled(false);
    _appMachine->connectToState("testerStarted", [this](bool active){
        ui->btnStop->setEnabled(active);
    });

    ui->labelInfo->setText("");
    _appMachine->connectToState("testerReset", [this](bool active){
        if (active) {
            ui->labelInfo->setText("");
            for (int i = 0; i < ui->listTests->count(); i++) {
                 setItemState(ui->listTests->item(i), MainWindow::tsUnknown);
            }
            ui->editLog->clear();
            ui->progressBar->setValue(0);
        }
    });

    _appMachine->connectToState("testerSummary", [this](bool active) {
        if (active) {
            this->printSummaryInfo();
        }
    });

    _appMachine->connectToState("testFinished", [this](bool active) {
        if (active) {
            const int index = _appMachine->dataModel()->scxmlProperty("i_TEST_INDEX").toInt();
            if (index >=0 && index <  ui->listTests->count()) {
                auto item = ui->listTests->item(index);

                if (_appMachine->isActive("testPassed")) {
                    setItemState(item, MainWindow::tsSuccess);
                    log("Test [" + item->text() + "] passed!", QtMsgType::QtInfoMsg);
                } else if (_appMachine->isActive("testSkipped")) {
                    setItemState(item, MainWindow::tsManual);
                    log("Test [" + item->text() + "] skipped!", QtMsgType::QtWarningMsg);
                } else if (_appMachine->isActive("testTimeout")) {
                    setItemState(item, MainWindow::tsTimeout);
                    log("Test [" + item->text() + "] failed by timeout!", QtMsgType::QtCriticalMsg);
                } else {
                    setItemState(item, MainWindow::tsError);
                    log("Test [" + item->text() + "] failed!", QtMsgType::QtCriticalMsg);
                }

                ui->progressBar->setValue(ui->progressBar->value() + 1);

                if (index == ui->listTests->count() - 1) {
                    _appMachine->submitEvent("Inp.Test.Summary");
                } else {
                    _appMachine->submitEvent("Inp.Test.Next");
                }
            }
        }
    }, Qt::QueuedConnection);

    _appMachine->connectToState("testInit", [this](bool active) {
        if (active) {
            const int index = _appMachine->dataModel()->scxmlProperty("i_TEST_INDEX").toInt();
            this->startTest(index);
        }
    });

    _appMachine->connectToState("testCancelled", [this](bool active) {
        if (active) {
            log("User cancelled!", QtWarningMsg);
            if (_interpreter) {
                _interpreter->stop();
                _interpreter.reset();
            }
        }
    });

    this->ui->labelTimeout->setVisible(false);
    _appMachine->connectToState("testIdle", [this](bool active) {
        this->ui->labelTimeout->setVisible(active);
    });

    _appMachine->connectToState("testIdleTimer", [this](bool active) {
        if (active) {
            const int elapsedSec =_appMachine->dataModel()->scxmlProperty("i_IDLE_TIME_SEC").toInt();
            const QString elapsed = QTime::fromMSecsSinceStartOfDay(elapsedSec*1000).toString("hh:mm:ss");
            this->ui->labelTimeout->setText("Timeout: " + elapsed);
        }
    });

    g_MainWindow = this;
    qInstallMessageHandler([](QtMsgType type, const QMessageLogContext &context, const QString &msg){
        if (g_MainWindow) {
            if (QString::compare(context.category, "qt.scxml.statemachine")==0) {

                if (msg.contains("ScxmlW3CTester"))
                    return;

                if (msg.contains("failed to parse") || msg.contains("had error")) {
                    type = QtMsgType::QtCriticalMsg;
                }

                if (g_MainWindow->ui->checkMonitor->isChecked() ||
                        (type == QtCriticalMsg || type == QtFatalMsg)) {

                    g_MainWindow->log(msg, type);
                }
            }
        }
    });
    QLoggingCategory::setFilterRules("qt.scxml.statemachine=true");

    QSettings settings(QDir(QCoreApplication::applicationDirPath()).filePath("settings.ini"), QSettings::IniFormat);
    ui->editDirectory->setText(settings.value("editDirectory.text").toString());
    ui->checkMonitor->setChecked(settings.value("checkMonitor.checked", ui->checkMonitor->isChecked()).toBool());

    if (ui->checkMonitor->isChecked())
        _monitor->setScxmlStateMachine(_appMachine);

    _appMachine->start();
}

MainWindow::~MainWindow()
{
    g_MainWindow = nullptr;

    QSettings settings(QDir(QCoreApplication::applicationDirPath()).filePath("settings.ini"), QSettings::IniFormat);
    settings.setValue("editDirectory.text", QFileInfo::exists(ui->editDirectory->text()) ?
                          ui->editDirectory->text() : QString(""));
    settings.setValue("checkMonitor.checked", ui->checkMonitor->isChecked());
    settings.sync();

    delete ui;
}

void MainWindow::startTest(const int index)
{
    if (index >= 0 && index < ui->listTests->count()) {
        auto item = ui->listTests->item(index);

        ui->listTests->setCurrentItem(item);

        setItemState(item, MainWindow::tsStarted);

        ui->labelInfo->setText(item->text());

        log("Starting " + item->text() + "...", QtDebugMsg);

        if (item->data(testRolesSpecial).toBool()) {
            _interpreter.reset();

            this->_appMachine->submitEvent("Inp.Test.Skipped");
        } else {
            const QString sFileName = item->data(testRolesPath).toString();

            _interpreter.reset(QScxmlStateMachine::fromFile(sFileName));

            const auto errors = _interpreter->parseErrors();
            if (errors.size()) {
                for (const auto &it : errors) {
                    log(it.toString(), QtCriticalMsg);
                }
            }

            connect(_interpreter.get(), &QScxmlStateMachine::runningChanged, this, [=](bool running) {
                if (running) {
                    this->_appMachine->submitEvent("Inp.Test.Started");
                }
            });

            connect(_interpreter.get(), &QScxmlStateMachine::finished, this, [=]() {
                const bool pass = this->_interpreter->isActive("pass");

                this->_appMachine->submitEvent(pass ? "Inp.Test.Passed" : "Inp.Test.Failed");
            });

            connect(_interpreter.get(), &QScxmlStateMachine::reachedStableState, this, [=]() {
                this->_appMachine->submitEvent("Inp.Test.Stable");
            });

            /* state machine activity */
            _interpreter->connectToEvent("*", [this](const QScxmlEvent &) {
                if (this->_appMachine->isActive("stableConfiguration")) {
                    this->_appMachine->submitEvent("Inp.Test.Active");
                }
            });

            _interpreter->start();

            if (!_interpreter->isRunning()) {
                this->_appMachine->submitEvent("Inp.Test.Timeout");
            }
        }
    }
}

void MainWindow::log(const QString &sMsg, const QtMsgType Severity)
{
    switch(Severity) {
    case QtInfoMsg: {
        ui->editLog->setTextColor("blue");
        ui->editLog->setFontWeight(QFont::Normal);

    }break;
    case QtWarningMsg: {
        ui->editLog->setTextColor("navy");
        ui->editLog->setFontWeight(QFont::Bold);

    }break;
    case QtCriticalMsg:
    case QtFatalMsg: {
        ui->editLog->setTextColor("red");
        ui->editLog->setFontWeight(QFont::Bold);

    }break;
    default: {
        ui->editLog->setTextColor("green");
        ui->editLog->setFontWeight(QFont::Normal);
    }
    }
    ui->editLog->append(sMsg);
}

void MainWindow::setItemState(QListWidgetItem *item, const MainWindow::TestState state)
{
    item->setData(testRolesState, state);
    item->setIcon(_icon[state]);
}

void MainWindow::setupDirectory()
{
    const QDir dirW3C(ui->editDirectory->text());

    ui->listTests->clear();
    ui->editLog->clear();

    if (!dirW3C.exists())
    {
        log("Directory [" + dirW3C.path() + "] does not exist!", QtCriticalMsg);
        ui->editDirectory->setStyleSheet("color: red;");
    } else {

        ui->editDirectory->setStyleSheet("color: black;");

        QStringList ignoredTest;
        const QString fileIgnoredTest = dirW3C.filePath("_qt_ignored.ini");

        QFile file(fileIgnoredTest);
        if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            QTextStream textStream(&file);

            while (!textStream.atEnd()) {
                const QString line = textStream.readLine().trimmed();
                if (!line.isEmpty() && !line.startsWith(";") && !line.startsWith("#"))
                    ignoredTest << line;
            }

            file.close();
        }

        QDirIterator it(dirW3C.absolutePath(), QStringList() << "*scxml", QDir::Files, QDirIterator::Subdirectories);
        while (it.hasNext()) {
            const QString sFilePath = it.next();
            const QString sTestFile = dirW3C.relativeFilePath(sFilePath);
            if (!sTestFile.contains("sub",Qt::CaseInsensitive)) {

                QString description = "";

                QDomDocument doc;
                QFile file(it.filePath());
                if (file.open(QIODevice::ReadOnly)) {
                    if (doc.setContent(&file)) {

                        /* 1 type: TOP-LEVEL COMMENT */
                        /* <!-- this is top-level comment --> */
                        /* <scxml/> */

                        for (int i=0; i < doc.childNodes().count(); i++) {
                            auto node = doc.childNodes().item(i);
                            if (node.isComment()) {
                                description = node.nodeValue().simplified();
                                break;
                            }
                            /* the first element must cancel scanning */
                            if (node.isElement())
                                break;
                        }

                        /* 2 type: FIRST SCXML CHILD COMMENT */
                        /* <!-- this is top-level comment --> */
                        /* <scxml/> */
                        if (description.isEmpty()) {
                            auto node = doc.documentElement();
                            if (!node.isNull()) {
                                auto child = node.firstChild();
                                if (child.isComment()) {
                                    description = child.nodeValue().simplified();
                                }
                            }
                        }
                    }
                    file.close();
                }

                QListWidgetItem *item = new QListWidgetItem(
                            _icon[MainWindow::tsUnknown], sTestFile, ui->listTests);
                item->setData(testRolesState, MainWindow::tsUnknown);
                item->setData(testRolesPath, sFilePath);
                // mark warning or restricted tests
                if (ignoredTest.contains(it.fileName(), Qt::CaseInsensitive)) {
                    item->setData(testRolesSpecial, true);
                }
                item->setData(testRolesDescription, description);

                ui->listTests->addItem(item);
            }
        }

        ui->progressBar->setMaximum(ui->listTests->count());
        if (ui->listTests->count()>0) {
            _appMachine->submitEvent("Inp.Dir.Ready");
        }
    }
}

void MainWindow::printSummaryInfo()
{
    int iPassed = 0;
    int iManual = 0;
    int iTimeout = 0;
    int iFailed = 0;

    const int iTotalCount = ui->listTests->count();

    for (int i = 0; i < iTotalCount; i++) {
        switch(ui->listTests->item(i)->data(testRolesState).toInt()) {
        case MainWindow::tsSuccess:
            iPassed++;
            break;
        case MainWindow::tsManual:
            iManual++;
            break;
        case MainWindow::tsTimeout:
            iTimeout++;
            break;
        default:
            iFailed++;
        }
    }

    const int iNotPassed = iTimeout + iFailed;

    log("Elapsed: "  +
        QTime::fromMSecsSinceStartOfDay(_elapsed.msecsTo(QTime::currentTime())).
        toString("hh:mm:ss.zzz"), QtInfoMsg);
    log("All " + QString::number(iTotalCount) + " tests were completed!", QtInfoMsg);
    log("Passed: " + QString::number(iPassed), QtInfoMsg);
    log("Manual or restricted: " + QString::number(iManual), QtInfoMsg);
    log("Timeout: " + QString::number(iTimeout), iTimeout ? QtCriticalMsg : QtInfoMsg);
    log("Failed: " + QString::number(iFailed), iFailed ? QtCriticalMsg : QtInfoMsg);
    log("Total Failed: " + QString::number(iNotPassed), iNotPassed ? QtCriticalMsg : QtInfoMsg);
}

void MainWindow::on_btnStart_clicked()
{
    _appMachine->submitEvent("Inp.Btn.Start");
}

void MainWindow::on_btnStop_clicked()
{
    _appMachine->submitEvent("Inp.Btn.Stop");
}

void MainWindow::on_btnReset_clicked()
{
    _appMachine->submitEvent("Inp.Btn.Reset");
}

void MainWindow::on_btnDir_clicked()
{
    const QString dir = QFileDialog::getExistingDirectory(this, tr("Select folder with SCXML W3C tests"),
                                                    ui->editDirectory->text(),
                                                    QFileDialog::DontResolveSymlinks);
    if (!dir.isEmpty()) {
        ui->editDirectory->setText(dir);
        _appMachine->submitEvent("Inp.Dir.Setup");
    }
}

void MainWindow::on_editDirectory_returnPressed()
{
    _appMachine->submitEvent("Inp.Dir.Setup");
}

void MainWindow::on_editDirectory_textChanged(const QString &)
{
    ui->editDirectory->setStyleSheet("color: blue");
}

QString MainWindow::StringToMarkdownEscaped(QString text) {
    text.replace("<", "\\<");
    text.replace(">", "\\>");

    text.replace(QRegularExpression("(?<![\\S`])(" + _markdownCodeRegs + ")(?![\\S`])"), "`\\1`");

    for (auto it = _scxmlLinks.begin(); it!=_scxmlLinks.end(); ++it) {
        text.replace("\\<" + it.key() + "\\>", "[\\<" + it.key() + "\\>](" + _scxmlLinksRepo + it.value() + ")");
    }

    return text;
}

void MainWindow::on_btnReport_clicked()
{
    if (!ui->listTests->count())
        return;

    QStringList reportList;

    ui->editLog->clear();

    reportList << "| Test | Result | Description |";
    reportList << "|---|---|---|";

    for (int i=0;i<ui->listTests->count();i++) {
        const TestState status = TestState(ui->listTests->item(i)->data(testRolesState).toInt());

        const QString &testname = ui->listTests->item(i)->text();
        const QString &statustext = TestStateToStatusString(status);
        const QString &description = ui->listTests->item(i)->data(testRolesDescription).toString();

        QStringList lines;
        lines << "[" + testname + "](" + testname + ")"
              << statustext
              << StringToMarkdownEscaped(description);

        QtMsgType logtype = QtDebugMsg;
        switch (status) {
        case tsSuccess:
        case tsManual:
            break;
        default:
            /* not passed */
            {
                logtype = QtCriticalMsg;
                for (auto &it: lines) {
                    if (!it.isEmpty())
                        it = "**" + it + "**";
                }
            }

        }

        reportList << ("| " + lines.join(" | ") + " |");

        /* couldn't make QTextEdit markdown work properly, so just log */
        log(testname + " | " + statustext + " | " + description, logtype);
    }

    const QDir dir(ui->editDirectory->text());
    QString reportFile = dir.filePath("report.md");
    reportFile = QFileDialog::getSaveFileName(this, tr("Save File"),
                               reportFile,
                               tr("Repors (*.md)"));
    if (!reportFile.isEmpty()) {
        QFile fOut(reportFile);
        if (fOut.open(QFile::WriteOnly | QFile::Text)) {
            QTextStream s(&fOut);
            for (const auto &it : reportList)
                s << it << '\n';
            fOut.close();
        }
    }

}

void MainWindow::on_checkMonitor_toggled(bool checked)
{
    _monitor->setScxmlStateMachine(checked ? _appMachine : nullptr);
}
