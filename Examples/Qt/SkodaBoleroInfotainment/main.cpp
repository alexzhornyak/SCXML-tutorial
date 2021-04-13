#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "maskedmousearea.h"
#include "scxmlboleroext.h"
#include "storageinfo.h"
#include "fileutils.h"
#include "scxmlexternmonitor2.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("AlexZhornyak");
    QCoreApplication::setOrganizationDomain("https://alexzhornyak.github.io/SCXML-tutorial/");
    QCoreApplication::setApplicationName("Skoda Bolero Infotainment Simulator");

    QGuiApplication app(argc, argv);

    qmlRegisterType<MaskedMouseArea>("MaskedMouseArea", 1, 0, "MaskedMouseArea");
    qmlRegisterType<ScxmlBoleroExt>("ScxmlBolero", 1, 0, "ScxmlBolero");
    qmlRegisterType<StorageInfo>("StorageInfo", 1, 0, "StorageInfo");
    qmlRegisterType<FileUtils>("FileUtils", 1, 0, "FileUtils");
    qmlRegisterType<Scxmlmonitor::UDPScxmlExternMonitor>("UDPScxmlExternMonitor", 1, 0, "UDPScxmlExternMonitor");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("s_APP_PATH", QCoreApplication::applicationDirPath());
    engine.load(QUrl(QLatin1String("qrc:/Qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
