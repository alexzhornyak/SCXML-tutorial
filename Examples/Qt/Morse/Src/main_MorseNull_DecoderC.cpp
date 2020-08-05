#include "widgetMorseNullDecoderC.h"
#include <QApplication>

#ifdef _SCXML_EXTERN_MONITOR_
    /* https://github.com/alexzhornyak/ScxmlEditor-Tutorial/blob/master/Include/scxmlexternmonitor.h */
    #include "scxmlexternmonitor.h"
#endif

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

#ifdef _SCXML_EXTERN_MONITOR_
    g_ScxmlStateMachineName = "ScxmlMorse";
    qInstallMessageHandler(myMessageOutput);
    QLoggingCategory::setFilterRules("qt.scxml.statemachine=true");
#endif

    WidgetMorseNullDecoderC w;
    w.show();

    return a.exec();
}
