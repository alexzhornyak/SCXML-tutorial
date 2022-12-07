#include "widgetMorse.h"
#include "ui_widgetMorse.h"

#include <QDebug>
#include <QMessageBox>
#include <QSvgRenderer>
#include <QGraphicsView>
#include <QGraphicsSvgItem>
#include <QScrollBar>

WidgetMorse::WidgetMorse(const QString &sScxmlFile, QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::WidgetMorse)
{
    ui->setupUi(this);

    const QString s_STATIC_GROUP("groupStatic");
    const QString s_DYNAMIC_GROUP("groupDynamic");

    auto renderer = new QSvgRenderer(QString(":/Morse.svg"),this);

    if (!renderer->elementExists(s_STATIC_GROUP)) {
        QMessageBox::critical(nullptr, "ERROR", "SVG element [" + s_STATIC_GROUP + "] is not found!");
        exit(EXIT_FAILURE);
        return;
    }

    if (!renderer->elementExists(s_DYNAMIC_GROUP)) {
        QMessageBox::critical(nullptr, "ERROR", "SVG element [" + s_DYNAMIC_GROUP + "] is not found!");
        exit(EXIT_FAILURE);
        return;
    }

    _machine = QScxmlStateMachine::fromFile(sScxmlFile);
    auto scxmlErrors = _machine->parseErrors();
    if (scxmlErrors.size()) {
        QMessageBox::critical(nullptr, "ERROR", "SCXML parsing errors!\n"
                                                + scxmlErrors[0].description());
        exit(EXIT_FAILURE);
        return;
    }

    _machine->connectToEvent("dash", this, &WidgetMorse::onDashReceived);

    _machine->connectToEvent("dot", this, &WidgetMorse::onDotReceived);

    _monitor = new Scxmlmonitor::UDPScxmlExternMonitor(_machine);

    _svgStaticItem = new QGraphicsSvgItem;
    _svgStaticItem->setSharedRenderer(renderer);
    _svgStaticItem->setElementId(s_STATIC_GROUP);

    _svgDynamicItem = new QGraphicsSvgItem();
    _svgDynamicItem->setSharedRenderer(renderer);
    _svgDynamicItem->setElementId(s_DYNAMIC_GROUP);

    auto graphicsScene = new QGraphicsScene(this);
    graphicsScene->setSceneRect(_svgStaticItem->boundingRect());

    auto staticBounds = renderer->boundsOnElement("groupStatic");
    _svgStaticItem->setPos(staticBounds.x(), staticBounds.y());

    graphicsScene->addItem(_svgStaticItem);

    auto dynamicBounds = renderer->boundsOnElement("groupDynamic");
    _svgDynamicItem->setPos(dynamicBounds.x(), dynamicBounds.y());

    graphicsScene->addItem(_svgDynamicItem);

    ui->graphicsView->setScene(graphicsScene);
}

WidgetMorse::~WidgetMorse()
{
    delete ui;

    if (_machine) {
        delete _machine;
    }
}

void WidgetMorse::onDashReceived(const QScxmlEvent &) {
    ui->editMorseCode->moveCursor(QTextCursor::End);
    ui->editMorseCode->insertPlainText("— ");
    ui->editMorseCode->moveCursor(QTextCursor::End);
}

void WidgetMorse::onDotReceived(const QScxmlEvent &) {
    ui->editMorseCode->moveCursor(QTextCursor::End);
    ui->editMorseCode->insertPlainText(". ");
    ui->editMorseCode->moveCursor(QTextCursor::End);
}

void WidgetMorse::doFitSvgInView(void) {
    if (_svgStaticItem) {
        ui->graphicsView->fitInView(_svgStaticItem, Qt::KeepAspectRatio);
    }
}

void WidgetMorse::appendSymbol(const QString &symbol) {
    ui->labelOutput->setText(ui->labelOutput->text() + symbol);

    ui->editMorseCode->append("");
}

void WidgetMorse::resizeEvent(QResizeEvent *event) {
    /* inherited */
    QMainWindow::resizeEvent(event);

    doFitSvgInView();
}

void WidgetMorse::showEvent(QShowEvent *event) {
    /* inherited */
    QMainWindow::showEvent(event);

    doFitSvgInView();
}

void WidgetMorse::on_pushButton_pressed()
{
    if (_svgDynamicItem) {
        auto centerPoint = _svgDynamicItem->boundingRect().center();

        // spring center compensation
        centerPoint.setX(centerPoint.x() + 0.0f);
        centerPoint.setY(centerPoint.y() + 40.0f);

        _svgDynamicItem->setTransformOriginPoint(centerPoint);
        _svgDynamicItem->setRotation(-5.0f);
    }

    if (_machine) {
        _machine->submitEvent("device.press");
    }
}

void WidgetMorse::on_pushButton_released()
{
    if (_svgDynamicItem) {
        _svgDynamicItem->setTransformOriginPoint(_svgDynamicItem->boundingRect().center());
        _svgDynamicItem->setRotation(0.0f);
    }

    if (_machine) {
        _machine->submitEvent("device.release");
    }
}

void WidgetMorse::on_pushButtonClear_clicked()
{
    ui->editMorseCode->clear();
    ui->labelOutput->clear();

    if (_machine) {
        _machine->submitEvent("input.restart");
    }
}

void WidgetMorse::on_pushButtonPopBack_clicked() {
    if (ui->labelOutput->text().length()) {
        QString sOutput = ui->labelOutput->text();
        sOutput.chop(1);
        ui->labelOutput->setText(sOutput);
    }
}

void WidgetMorse::on_checkMonitor_toggled(bool checked) {
    if (_monitor && _machine) {
        _monitor->setScxmlStateMachine(checked ? _machine : nullptr);
    }
}
