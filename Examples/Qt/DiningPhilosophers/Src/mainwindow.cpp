#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QLoggingCategory>
#include <QSvgRenderer>
#include <QGraphicsScene>
#include <QMessageBox>
#include "scxmlexternmonitor2.h"

class CenteredTextItem: public QGraphicsSimpleTextItem {
    const QPointF _WH;

    std::size_t _counter = 0;

    const QString _pre;

public:

    explicit CenteredTextItem(const QString &pre, const QPointF &width_height, QGraphicsItem *parent = nullptr):
                                QGraphicsSimpleTextItem("", parent), _WH(width_height), _pre(pre) {
    }

    virtual void paint(QPainter *painter, const QStyleOptionGraphicsItem * /* option */, QWidget * /* widget */) override {
        QRectF bounds = boundingRect();
        bounds.setWidth(_WH.x());
        bounds.setHeight(_WH.y());
        painter->setFont(this->font());
        painter->drawText(bounds, Qt::AlignCenter, QString("%1 %2").arg(_pre).arg(_counter));
    }

    void incrementCounter() { _counter++; }

    std::size_t counter() const { return _counter; }
};

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    _machine = QScxmlStateMachine::fromFile(":/machine_dining_philosphers.flat.scxml");
    auto scxmlErrors = _machine->parseErrors();
    if (scxmlErrors.size()) {
        QMessageBox::critical(nullptr, "ERROR", "SCXML parsing errors!\n"
                                                + scxmlErrors[0].description());
        exit(EXIT_FAILURE);
    }

    auto svgRenderer = new QSvgRenderer(QLatin1String(":/dininig_philosophers.svg"), ui->centralwidget);

    auto graphicsScene = new QGraphicsScene(this);

    auto funcCreateItem = [&](const QString &sID) {
        if (!svgRenderer->elementExists(sID)) {
            exit(EXIT_FAILURE);
        }
        auto item = new QGraphicsSvgItem;
        item->setSharedRenderer(svgRenderer);
        item->setElementId(sID);
        graphicsScene->addItem(item);
        const auto staticBounds = svgRenderer->boundsOnElement(sID);
        item->setPos(staticBounds.x(), staticBounds.y());

        return qMakePair(item, staticBounds);
    };

    auto funcAddItem = [&](const QString &sID, const std::size_t nIndex,
            std::vector<QGraphicsSvgItem*> &vecItems) {

        auto pairItem = funcCreateItem(sID);
        vecItems[nIndex] = pairItem.first;
        vecItems[nIndex]->hide();

        return pairItem;
    };

    funcCreateItem("philosophers_static");

    enum class PhilosopherState { Thinking, Hungry, Eating, MAXSIZE };
    static auto philosopherStateToString = [](const PhilosopherState state) {
        switch (state) {
        case PhilosopherState::Thinking: return QString("Thinking");
        case PhilosopherState::Hungry: return QString("Hungry");
        case PhilosopherState::Eating: return QString("Eating");
        default:
            break;
        }
        return QString("UNKNOWN");
    };

    for (std::size_t i=0; i < n_PHILOSOPHERS_COUNT ; i++ ) {
        const std::size_t nPhilosopher = i + 1;

        /* Fork items */
        funcAddItem(QString("fork%1").arg(nPhilosopher), i, _vecForks);

        funcAddItem(QString("p%1_left").arg(nPhilosopher), i, _vecPhilosophersLeftHand);

        funcAddItem(QString("p%1_right").arg(nPhilosopher), i, _vecPhilosophersRightHand);

        /* Eat items */

        auto pairItem = funcAddItem(QString("p%1_eat").arg(nPhilosopher), i, _vecPhilosophersEat);

        _vecPhilosophersEatCounter[i] = new CenteredTextItem("Eat:",
                                                               QPointF(pairItem.second.width(), pairItem.second.height()));
        graphicsScene->addItem(_vecPhilosophersEatCounter[i]);
        _vecPhilosophersEatCounter[i]->setPos(pairItem.second.x(), pairItem.second.y());
        _vecPhilosophersEatCounter[i]->setFont(QFont("Arial", 10));

        /* Think items */
        auto thinkItem = funcAddItem(QString("p%1_think").arg(nPhilosopher), i, _vecPhilosophersThink);

        _vecPhilosophersThinkCounter[i] = new CenteredTextItem("Th:",
                                                             QPointF(thinkItem.second.width(), thinkItem.second.height()));
        graphicsScene->addItem(_vecPhilosophersThinkCounter[i]);
        _vecPhilosophersThinkCounter[i]->setPos(thinkItem.second.x(), thinkItem.second.y());
        _vecPhilosophersThinkCounter[i]->setFont(QFont("Arial", 8));

        /* Labels has special positioning */
        _vecPhilosophersLabel[i] = graphicsScene->addSimpleText(QString("P%1: Waiting ...").arg(nPhilosopher), QFont("Arial", 14));
        switch (i) {
        case 0:
            _vecPhilosophersLabel[i]->setPos(thinkItem.second.x() - 50, thinkItem.second.y() - 100);
            break;
        case 1:
            _vecPhilosophersLabel[i]->setPos(thinkItem.second.x() - 50, thinkItem.second.y() - 50);
            break;
        case 2:
            _vecPhilosophersLabel[i]->setPos(thinkItem.second.x() - 25, thinkItem.second.y() - 50);
            break;
        case 3:
            _vecPhilosophersLabel[i]->setPos(thinkItem.second.x() - 25, thinkItem.second.y() - 100);
            break;
        case 4:
            _vecPhilosophersLabel[i]->setPos(thinkItem.second.x() - 40, thinkItem.second.y() + 60);
            break;
        }

        for (std::size_t nState=0; nState < static_cast<std::size_t>(PhilosopherState::MAXSIZE);nState++) {
            const PhilosopherState state = static_cast<PhilosopherState>(nState);

            const QString literalState = philosopherStateToString(state);

            _machine->connectToState(QString("P%1_%2").arg(nPhilosopher).arg(literalState),
                                     [=](bool active){

                switch (state) {
                case PhilosopherState::Thinking: {
                    if (active) { _vecPhilosophersThinkCounter.at(i)->incrementCounter(); }

                    _vecPhilosophersThink.at(i)->setVisible(active);
                } break;
                case PhilosopherState::Eating: {
                    if (active) { _vecPhilosophersEatCounter.at(i)->incrementCounter(); }

                    _vecPhilosophersEat.at(i)->setVisible(active);
                } break;
                default:
                    break;
                }

                if (active) {
                    _vecPhilosophersLabel.at(i)->setText(QString("P%1: %2").arg(nPhilosopher).arg(literalState));
                }
            });
        }

    }

    ui->graphicsView->setScene(graphicsScene);

    _machine->connectToEvent("taken.*", [this](const QScxmlEvent &event){
        try {
            auto lines = event.name().split(".");
            if (lines.size()!=2)
                throw std::runtime_error(QString("Requires 2 args but got:[%1]")
                                         .arg(lines.size()).toStdString());

            const std::size_t nFork = std::stoul(lines[1].toStdString()) - 1;
            const std::size_t nVal = event.data().toUInt();
            const std::size_t nPhilosopher = nVal - 1;

            _vecForks.at(nFork)->setVisible(nVal!=0);

            auto dm = _machine->dataModel();
            if (!dm)
                throw std::runtime_error("Can not retrieve datamodel!");

            const QString s_LITERAL_HAND_COMPLIANCE = "t_HAND_COMPLIANCE";
            if (!dm->hasScxmlProperty(s_LITERAL_HAND_COMPLIANCE))
                throw std::runtime_error("Scxml data:[" + s_LITERAL_HAND_COMPLIANCE.toStdString() + "] is not found!");

            const auto vHandCompliance = dm->scxmlProperty(s_LITERAL_HAND_COMPLIANCE).toList();
            for (int nP=0; nP<vHandCompliance.size();nP++) {
                const auto vLeftRight = vHandCompliance[nP].toList();
                if (vLeftRight.size()!=2)
                    throw std::runtime_error(
                            QString("Require Left-Right pair size 2 bug got:[%1]")
                            .arg(vLeftRight.size()).toStdString()
                            );

                const auto nForkLeft = vLeftRight.at(0).toUInt() - 1;
                const auto nForkRight = vLeftRight.at(1).toUInt() - 1;

                const bool bMatchPhilosopher = nPhilosopher == static_cast<std::size_t>(nP);

                if (nForkLeft == nFork) {
                    _vecPhilosophersLeftHand.at(static_cast<std::size_t>(nP))->setVisible(bMatchPhilosopher);
                }

                if (nForkRight == nFork) {
                    _vecPhilosophersRightHand.at(static_cast<std::size_t>(nP))->setVisible(bMatchPhilosopher);
                }
            }

        } catch (const std::exception &e) {
            qCritical() << __FUNCTION__ << "> " << e.what();
        }
    });

}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_btnStart_clicked()
{
    if (_machine) {
        _machine->start();

        ui->btnStart->setEnabled(false);
    }
}

void MainWindow::on_spinDelay_valueChanged(int arg1)
{
    if (_machine) {
        _machine->submitEvent("update.delay", arg1);
    }
}
