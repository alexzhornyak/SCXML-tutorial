QT       += core gui svg scxml xml

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

qtHaveModule(scxml-private) {
    QT += scxml-private
    DEFINES += USE_SCXML_TRIGGERED_TRANSITIONS
}


INCLUDEPATH += ../Include

SOURCES += \
    Src/main.cpp \
    Src/mainwindow.cpp

HEADERS += \
    ../Include/scxmlexternmonitor2.h \
    ../Include/scxmlsvgitem.h \
    ../Include/scxmlsvgview.h \
    Src/mainwindow.h

FORMS += \
    Src/mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    res.qrc

STATECHARTS += \
    Src/machine_dining_philosphers.flat.scxml
