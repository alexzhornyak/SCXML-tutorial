#include "processmainwindow.h"

#include <QFileInfo>
#include <QDir>

#include <QtWidgets/QFrame>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>

ProcessMainWindow::ProcessMainWindow(QWidget *parent /*= nullptr*/):MainWindow(parent)
{
    this->setWindowTitle("Qt Process SCXML Tester by Alex Zhornyak");

    QVBoxLayout *uiVertLayout = this->findChild<QVBoxLayout*>("verticalLayout");
    if (uiVertLayout) {
        QFrame *frame = new QFrame(this);

        QHBoxLayout *horizontalLayout = new QHBoxLayout(frame);
        QLabel *label = new QLabel(frame);
        label->setText("Process");
        horizontalLayout->addWidget(label);
        _editProcess = new QLineEdit(frame);
        horizontalLayout->addWidget(_editProcess);

        QLabel *label_2 = new QLabel(frame);
        label_2->setText("Args");
        horizontalLayout->addWidget(label_2);
        _editArguments = new QLineEdit(frame);
        _editArguments->setText("-f $(FileName)");
        horizontalLayout->addWidget(_editArguments);

        QLabel *label3 = new QLabel(frame);
        label3->setText("Pass Regex");
        horizontalLayout->addWidget(label3);
        _editPassRegex = new QLineEdit(frame);
        horizontalLayout->addWidget(_editPassRegex);

        QSizePolicy sizePolicy(QSizePolicy::Preferred, QSizePolicy::Fixed);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(frame->sizePolicy().hasHeightForWidth());
        frame->setSizePolicy(sizePolicy);

        uiVertLayout->insertWidget(3,frame);

        if (_settings) {
            const QString processPath = _settings->value("editProcess.text").toString();
            if (!processPath.isEmpty())
                _editProcess->setText(processPath);

            const QString args = _settings->value("editArguments.text").toString();
            if (!args.isEmpty())
                _editArguments->setText(args);

            const QString regex = _settings->value("editPassRegex.text").toString();
            if (!regex.isEmpty())
                _editPassRegex->setText(regex);
        }

        if (_appMachine) {
            _appMachine->connectToState("testCancelled", [this](bool active) {
                if (active) {
                    log("User cancelled!", QtWarningMsg);
                    if (_interpreter) {                        
                        _interpreter->kill();
                        _interpreter->waitForFinished();
                        _interpreter.reset();
                    }
                }
            });
        }
    }
}

ProcessMainWindow::~ProcessMainWindow()
{
    if (_settings) {
        _settings->setValue("editProcess.text", _editProcess->text());
        _settings->setValue("editArguments.text", _editArguments->text());
        _settings->setValue("editPassRegex.text", _editPassRegex->text());
        _settings->sync();
    }
}

void ProcessMainWindow::processTest(const QString &fileName, const bool isSpecial)
{
    _flagTestPassed = false;

    if (isSpecial) {
        _interpreter.reset();

        this->_appMachine->submitEvent("Inp.Test.Skipped");
    } else {

        _interpreter.reset(new QProcess);

        connect(_interpreter.get(), &QProcess::started, this, [=]() {
            this->_appMachine->submitEvent("Inp.Test.Started");
        });

        connect(_interpreter.get(), QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
            [=](int /* exitCode */, QProcess::ExitStatus /* exitStatus */){

            bool pass = _flagTestPassed;
            this->_appMachine->submitEvent(pass ? "Inp.Test.Passed" : "Inp.Test.Failed");
        });

        /* state machine activity */
        connect(_interpreter.get(), &QProcess::readyReadStandardOutput, this, [=]() {            
            if (_interpreter) {
                this->_appMachine->submitEvent("Inp.Test.Active");

                const QString out = _interpreter->readAllStandardOutput();

                QRegExp rx(_editPassRegex->text());
                for (auto it : out.split("\n")) {
                    if (rx.exactMatch(it.trimmed()))
                        _flagTestPassed = rx.exactMatch(it.trimmed());
                }

                this->log(out, QtDebugMsg);

                this->_appMachine->submitEvent("Inp.Test.Stable");
            }
        });
        connect(_interpreter.get(), &QProcess::readyReadStandardError, this, [=]() {
            this->_appMachine->submitEvent("Inp.Test.Active");

            this->log(_interpreter->readAllStandardError(), QtCriticalMsg);

            this->_appMachine->submitEvent("Inp.Test.Stable");
        });

        const QStringList args = QProcess::splitCommand(_editArguments->text().replace("$(FileName)",
                 QDir::toNativeSeparators(fileName)));
        QFileInfo info(_editProcess->text());
        try {
            if (!info.exists())
                throw std::runtime_error("Process app does not exist!");

            if (_editPassRegex->text().isEmpty())
                throw std::runtime_error("Passing test Regex is empty!");

            _interpreter->start(_editProcess->text(), args);

            if (!_interpreter->waitForStarted(1000)) {
                throw std::runtime_error("Couldn't start a process within 1 sec!");
            } else {
                _appMachine->connectToState("testTimeout", [this](bool active) {
                    if (active) {
                        if (_interpreter) {
                            log("Terminating process!", QtWarningMsg);

                            _interpreter->kill();
                            _interpreter->waitForFinished();
                            _interpreter.reset();
                        }
                    }

                });
            }
        }  catch (std::exception &e) {
            log(QString("ERROR> Process:[%1] was not started!")
                .arg(_editProcess->text()).arg(e.what()), QtCriticalMsg);
            log(QString("ERROR> %1").arg(e.what()), QtCriticalMsg);
            this->_appMachine->submitEvent("Inp.Btn.Stop");
        }

    }
}
