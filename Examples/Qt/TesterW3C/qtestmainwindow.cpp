#include "qtestmainwindow.h"

QTestMainWindow::QTestMainWindow(QWidget *parent /*= nullptr*/):MainWindow(parent)
{
    if (_appMachine) {
        _appMachine->connectToState("testCancelled", [this](bool active) {
            if (active) {
                log("User cancelled!", QtWarningMsg);
                if (_interpreter) {
                    _interpreter->stop();
                    _interpreter.reset();
                }
            }
        });
    }
}

void QTestMainWindow::processTest(const QString &fileName, const bool isSpecial)
{
    if (isSpecial) {
        _interpreter.reset();

        this->_appMachine->submitEvent("Inp.Test.Skipped");
    } else {

        _interpreter.reset(QScxmlStateMachine::fromFile(fileName));

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
            if (this->_appMachine->isActive("testIdle")) {
                this->_appMachine->submitEvent("Inp.Test.Active");
            }
        });

        _interpreter->start();

        if (!_interpreter->isRunning()) {
            this->_appMachine->submitEvent("Inp.Test.Timeout");
        }
    }
}
