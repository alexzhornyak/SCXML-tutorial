#include "widgetMorseEcma.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    WidgetMorseEcma w;
    w.show();

    return a.exec();
}
