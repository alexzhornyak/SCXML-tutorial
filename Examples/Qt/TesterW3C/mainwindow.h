#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QListWidgetItem>
#include <QTime>
#include <QScxmlStateMachine>
#include <QTimer>

#include "machine.h"

#include "scxmlexternmonitor2.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

    void log(const QString &sMsg, const QtMsgType severity);

private slots:
    void on_btnStop_clicked();

    void on_btnStart_clicked();

    void on_btnReset_clicked();

    void on_btnDir_clicked();

    void on_editDirectory_returnPressed();

    void on_editDirectory_textChanged(const QString &);

    void on_btnReport_clicked();

    void on_checkMonitor_toggled(bool checked);

private:
    Ui::MainWindow *ui;

    enum TestState {
        tsSuccess,
        tsError,
        tsStarted,
        tsUnknown,
        tsManual,
        tsTimeout,
        tsMAXSIZE
    };

    inline static QString TestStateToStatusString(const TestState state) {
        switch (state) {
        case tsSuccess: return "Pass";
        case tsManual: return "Manual";
        case tsTimeout: return "Timeout";
        }
        return "Fail";
    }

    const QString _scxmlLinksRepo = "https://github.com/alexzhornyak/SCXML-tutorial/tree/master/Doc/";
    QMap<QString, QString> _scxmlLinks;
    QString _markdownCodeRegs;
    QString StringToMarkdownEscaped(QString text);

    QIcon _icon[tsMAXSIZE];

    QTime _elapsed;

    std::unique_ptr<QScxmlStateMachine> _interpreter;

    ScxmlW3CTester *_appMachine = nullptr;
    Scxmlmonitor::UDPScxmlExternMonitor *_monitor = nullptr;

    void startTest(const int index);

    void setItemState(QListWidgetItem *item, const TestState state);

    void setupDirectory();

    void printSummaryInfo(void);
};

Q_DECLARE_METATYPE(QListWidgetItem*)
Q_DECLARE_METATYPE(MainWindow*)

#endif // MAINWINDOW_H
