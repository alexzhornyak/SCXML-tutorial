#include "mainwindow.h"
#include "ui_mainwindow.h"

#include "RootMachine.h"
#include "rootmodel.h"
#include "childmodel.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    this->setWindowTitle("Qt SCXML CPP Invoke Demo by Alex Zhornyak");

    _model = new RootDataModel(ui->memo);
    _childModel = new ChildDataModel(ui->memo);
    _machine = new RootMachine;
    _machine->setDataModel(_model);

    _machine->connectToEvent("out.*", [this](const QScxmlEvent &event){
        this->ui->memo->appendPlainText("Event: " + event.name());
    });

    _svgRootMonitor = new Scxmlmonitor::ScxmlSvgView(_machine, ":/Model/RootMachine.svg");
    _svgRootMonitor->resize(300, 350);
    _svgRootMonitor->move(10, 50);
    _svgRootMonitor->setParent(this);
    _svgRootMonitor->show();

    _svgChildMonitor = new Scxmlmonitor::ScxmlSvgView(
                nullptr, ":/Model/ChildMachine.svg");
    _svgChildMonitor->resize(650, 250);
    _svgChildMonitor->move(330, 50);
    _svgChildMonitor->setParent(this);
    _svgChildMonitor->show();

    connect(_machine, &QScxmlStateMachine::invokedServicesChanged,
            this, [this](const QVector<QScxmlInvokableService *> &invokedServices){

        ChildMachine *childMachine = nullptr;
        auto svgItem = _svgChildMonitor->getSvgMonitorItem();

        for (auto it : invokedServices) {
            QScxmlStateMachine *submachine = qvariant_cast<QScxmlStateMachine *>(it->property("stateMachine"));
            if (submachine) {
                childMachine = dynamic_cast<ChildMachine*>(submachine);
                if (childMachine) {
                    this->ui->memo->appendPlainText("Child machine started!");

                    childMachine->setDataModel(_childModel);
                    childMachine->connectToEvent("out.*", [this](const QScxmlEvent &event){
                        this->ui->memo->appendPlainText("Event: " + event.name());
                    });

                    if (svgItem) {
                        svgItem->setScxmlStateMachine(childMachine);
                    }

                    childMachine->start();
                }
            }
        }

        if (svgItem && !childMachine) {
            svgItem->setScxmlStateMachine(nullptr);
        }

        this->ui->pushButton->setText(childMachine ?
                                          "Submachine: ON (Click to stop)":
                                          "Submachine: OFF (Click to start)");
    });

    _machine->start();
}

MainWindow::~MainWindow()
{
    if (_svgRootMonitor) {
        delete _svgRootMonitor;
        _svgRootMonitor = nullptr;
    }

    if (_svgChildMonitor) {
        delete _svgChildMonitor;
        _svgChildMonitor = nullptr;
    }

    if (_machine) {
        delete _machine;
        _machine = nullptr;
    }
    if (_model) {
        delete _model;
        _model = nullptr;
    }

    delete ui;
}


void MainWindow::on_pushButton_clicked()
{
    if (_machine) {
        _machine->submitEvent("in.test");
    }
}

