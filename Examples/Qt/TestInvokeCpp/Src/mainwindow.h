#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

#include "scxmlsvgview.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class RootMachine;
class RootDataModel;
class ChildDataModel;

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void on_pushButton_clicked();

private:
    Ui::MainWindow *ui = nullptr;

    RootMachine *_machine = nullptr;
    RootDataModel *_model = nullptr;
    ChildDataModel *_childModel = nullptr;

    Scxmlmonitor::ScxmlSvgView *_svgRootMonitor = nullptr;
    Scxmlmonitor::ScxmlSvgView *_svgChildMonitor = nullptr;
};
#endif // MAINWINDOW_H
