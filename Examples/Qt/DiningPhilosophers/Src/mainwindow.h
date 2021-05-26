#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QGraphicsSvgItem>
#include <QScxmlStateMachine>

#include <vector>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class CenteredTextItem;

const std::size_t n_PHILOSOPHERS_COUNT = 5;

namespace Scxmlmonitor {
    class ScxmlSvgView;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow() override;

protected:

    virtual void closeEvent(QCloseEvent * event) override;

private slots:
    void on_btnStart_clicked();

    void on_spinDelay_valueChanged(int arg1);

private:
    Ui::MainWindow *ui = nullptr;

    std::vector<QGraphicsSvgItem*> _vecForks{n_PHILOSOPHERS_COUNT,nullptr};
    std::vector<QGraphicsSvgItem*> _vecPhilosophersLeftHand{n_PHILOSOPHERS_COUNT,nullptr};
    std::vector<QGraphicsSvgItem*> _vecPhilosophersRightHand{n_PHILOSOPHERS_COUNT,nullptr};
    std::vector<QGraphicsSvgItem*> _vecPhilosophersEat{n_PHILOSOPHERS_COUNT,nullptr};
    std::vector<QGraphicsSvgItem*> _vecPhilosophersThink{n_PHILOSOPHERS_COUNT,nullptr};

    std::vector<CenteredTextItem*> _vecPhilosophersEatCounter{n_PHILOSOPHERS_COUNT,nullptr};
    std::vector<CenteredTextItem*> _vecPhilosophersThinkCounter{n_PHILOSOPHERS_COUNT,nullptr};

    std::vector<QGraphicsSimpleTextItem*> _vecPhilosophersLabel{n_PHILOSOPHERS_COUNT,nullptr};

    QScxmlStateMachine *_machine = nullptr;

    Scxmlmonitor::ScxmlSvgView *_svgTopMonitor = nullptr;
    Scxmlmonitor::ScxmlSvgView *_svgSubMonitor = nullptr;

    void createMonitorManager(void);
};
#endif // MAINWINDOW_H
