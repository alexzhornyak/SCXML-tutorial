#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "StopWatch.h"
#include "scxmlsvgqmlitem.h"

#include <QQuickWindow>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    qmlRegisterType<ScxmlStopWatch>("ScxmlStopWatch", 1, 0, "ScxmlStopWatch");
    qmlRegisterType<Scxmlmonitor::ScxmlSvgQmlMonitor>("ScxmlSvgQmlMonitor", 1, 0, "ScxmlSvgQmlMonitor");

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
