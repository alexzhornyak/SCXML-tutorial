#include "widgetMorseNullDecoderC.h"
#include "ui_widgetMorse.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QMessageBox>
#include <QDebug>

WidgetMorseNullDecoderC::WidgetMorseNullDecoderC(): WidgetMorse(":/morseNullDecoderC.scxml")
{
    this->setWindowTitle("Morse Code Trainer (NULL datamodel with C-side parser)");

    QFile fileMorseRef(":/morseCodeReference.json");
    if (!fileMorseRef.open(QIODevice::ReadOnly)) {
        QMessageBox::critical(nullptr, "ERROR", "Can not open [MorseCodeReference.json]!");
        exit(EXIT_FAILURE);
        return;
    }
    QJsonDocument doc = QJsonDocument::fromJson(fileMorseRef.readAll());
    auto obj = doc.object();
    for (auto it=obj.begin();it!=obj.end();++it) {
       _codeReference[it.key()] = it.value().toString();
    }

    _machine->connectToEvent("long_pause", [this](const QScxmlEvent &){
        auto symbol = _codeReference.find(_buffer);

        /* if Morse code combination is not found
         * we will delete last character and try again */
        while (symbol == _codeReference.end() && !_buffer.isEmpty()) {
            _buffer.chop(1);
            symbol = _codeReference.find(_buffer);
        }

        if (symbol != _codeReference.end()) {
            appendSymbol(symbol->second);
        }
        else {
            /* this mustn't happen */
            ui->editMorseCode->append("^^^ Not Defined! ^^^");
            ui->editMorseCode->append("");
        }

        _buffer.clear();
    });

    _machine->start();
}

void WidgetMorseNullDecoderC::onDashReceived(const QScxmlEvent &event) {
    /* inherited */
    WidgetMorse::onDashReceived(event);

    _buffer += "-";
}

void WidgetMorseNullDecoderC::onDotReceived(const QScxmlEvent &event) {
    /* inherited */
    WidgetMorse::onDotReceived(event);

    _buffer += ".";
}
