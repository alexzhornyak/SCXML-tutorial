#ifndef QTESTMAINWINDOW_H
#define QTESTMAINWINDOW_H

#include "mainwindow.h"

class QTestMainWindow : public MainWindow
{
public:
    QTestMainWindow(QWidget *parent = nullptr);
protected:
    virtual void processTest(const QString &fileName, const bool isSpecial) override;
    virtual QString _ignoredListFileName(void) override { return "_qt_ignored.ini"; }
private:
    std::unique_ptr<QScxmlStateMachine> _interpreter;
};

#endif // QTESTMAINWINDOW_H
