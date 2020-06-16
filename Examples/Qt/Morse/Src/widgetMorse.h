#ifndef WidgetMorse_H
#define WidgetMorse_H

#include <QMainWindow>
#include <QScxmlStateMachine>

namespace Ui {
class WidgetMorse;
}

class QGraphicsSvgItem;

class WidgetMorse : public QMainWindow
{
    Q_OBJECT

public:
    explicit WidgetMorse(const QString &sScxmlFile, QWidget *parent = 0);
    ~WidgetMorse();

protected slots:

    virtual void onDashReceived(const QScxmlEvent &event);

    virtual void onDotReceived(const QScxmlEvent &event);

protected:
    virtual void resizeEvent(QResizeEvent *event) override;

    virtual void showEvent(QShowEvent *event) override;

    void appendSymbol(const QString &symbol);

    Ui::WidgetMorse *ui;

    QScxmlStateMachine *_machine = nullptr;

private slots:
    void on_pushButton_pressed();

    void on_pushButton_released();

    void on_pushButtonClear_clicked();

    void on_pushButtonPopBack_clicked();

private:

    QGraphicsSvgItem *_svgDynamicItem = nullptr;
    QGraphicsSvgItem *_svgStaticItem = nullptr;

    void doFitSvgInView(void);
};

#endif // WidgetMorse_H
