#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "maskedmousearea.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
	qmlRegisterType<MaskedMouseArea>("Example", 1, 0, "MaskedMouseArea");
	
    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/Qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
