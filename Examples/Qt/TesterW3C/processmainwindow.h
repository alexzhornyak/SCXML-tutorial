#ifndef PROCESSMAINWINDOW_H
#define PROCESSMAINWINDOW_H

#include "mainwindow.h"

#include <QProcess>

class ProcessMainWindow : public MainWindow
{
public:
    ProcessMainWindow(QWidget *parent = nullptr);
    virtual ~ProcessMainWindow(void);
protected:
    virtual void processTest(const QString &fileName, const bool isSpecial) override;
    virtual QString _ignoredListFileName(void) override { return "_process_ignored.ini"; }
private:
    std::unique_ptr<QProcess> _interpreter;
    QLineEdit *_editProcess = nullptr;
    QLineEdit *_editArguments = nullptr;
    QLineEdit *_editPassRegex = nullptr;
    bool _flagTestPassed = false;
};

#endif // PROCESSMAINWINDOW_H
