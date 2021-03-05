#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "StopWatch.h"
#include "scxmlexternmonitor2.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<ScxmlStopWatch>("ScxmlStopWatch", 1, 0, "ScxmlStopWatch");
    qmlRegisterType<Scxmlmonitor::UDPScxmlExternMonitor>("UDPScxmlExternMonitor", 1, 0, "UDPScxmlExternMonitor");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
