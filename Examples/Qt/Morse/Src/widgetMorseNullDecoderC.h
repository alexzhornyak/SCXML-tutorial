#ifndef WIDGETMORSENULL_H
#define WIDGETMORSENULL_H

#include "widgetMorse.h"
#include <map>

class WidgetMorseNullDecoderC : public WidgetMorse
{
public:

    WidgetMorseNullDecoderC();

protected slots:

    virtual void onDashReceived(const QScxmlEvent &event) override;

    virtual void onDotReceived(const QScxmlEvent &event) override;

private:

    std::map<QString, QString> _codeReference;
    QString _buffer;
};

#endif // WIDGETMORSENULL_H
