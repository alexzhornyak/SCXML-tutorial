#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "StopWatch.h"

#ifdef _SCXML_EXTERN_MONITOR_
    #include "scxmlexternmonitor.h"
#endif

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<ScxmlStopWatch>("ScxmlStopWatch", 1, 0, "ScxmlStopWatch");

#ifdef _SCXML_EXTERN_MONITOR_
    g_ScxmlStateMachineName = "ScxmlStopWatch";
    qInstallMessageHandler(myMessageOutput);
    QLoggingCategory::setFilterRules("qt.scxml.statemachine=true");
#endif

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
