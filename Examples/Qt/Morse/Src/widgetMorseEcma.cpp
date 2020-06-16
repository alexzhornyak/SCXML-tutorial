#include "widgetMorseEcma.h"
#include "ui_widgetMorse.h"

WidgetMorseEcma::WidgetMorseEcma(): WidgetMorse(":/morseEcma.scxml")
{
    this->setWindowTitle("Morse Code Trainer (EcmaScript datamodel)");

    _machine->connectToEvent("out.symbol", [this](const QScxmlEvent &event){
        appendSymbol(event.data().toString());
    });

    _machine->start();
}
