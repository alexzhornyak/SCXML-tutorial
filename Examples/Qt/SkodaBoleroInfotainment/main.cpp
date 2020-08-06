#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "maskedmousearea.h"
#include "scxmlboleroext.h"

#ifdef _SCXML_EXTERN_MONITOR_
    #include "scxmlexternmonitor.h"
#endif

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<MaskedMouseArea>("MaskedMouseArea", 1, 0, "MaskedMouseArea");
    qmlRegisterType<ScxmlBoleroExt>("ScxmlBolero", 1, 0, "ScxmlBolero");
	
#ifdef _SCXML_EXTERN_MONITOR_
    g_ScxmlStateMachineName = "ScxmlBolero";
    qInstallMessageHandler(myMessageOutput);
    QLoggingCategory::setFilterRules("qt.scxml.statemachine=true");
#endif

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("s_APP_PATH", QCoreApplication::applicationDirPath());
    engine.load(QUrl(QLatin1String("qrc:/Qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
