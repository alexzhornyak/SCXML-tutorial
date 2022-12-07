QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

include(../Include/scxmlsvg.pri)

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    Src/main.cpp \
    Src/mainwindow.cpp

HEADERS += \
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
