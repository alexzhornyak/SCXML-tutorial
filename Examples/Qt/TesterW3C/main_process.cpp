#include "processmainwindow.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    ProcessMainWindow w;
    w.show();

    return a.exec();
}
