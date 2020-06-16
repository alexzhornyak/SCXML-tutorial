#include "widgetMorseNull.h"
#include "ui_widgetMorse.h"

WidgetMorseNull::WidgetMorseNull(): WidgetMorse(":/morseNull.scxml")
{
    this->setWindowTitle("Morse Code Trainer (NULL datamodel)");

    _machine->connectToEvent("out.*", [this](const QScxmlEvent &event){
        bool ok;
        const char chBuff = event.name().replace("out.","").toInt(&ok, 16);
        if (ok) {
            appendSymbol(QString(chBuff));
        }
    });

    _machine->start();
}
