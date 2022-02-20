#ifndef ROOTMODEL_H
#define ROOTMODEL_H

#include <QScxmlCppDataModel>
#include <QPlainTextEdit>

class RootDataModel: public QScxmlCppDataModel
{
    Q_OBJECT
    Q_SCXML_DATAMODEL

    QPlainTextEdit *_edit = nullptr;
public:
    RootDataModel(QPlainTextEdit *edit,
                  QObject *parent = nullptr):
        QScxmlCppDataModel(parent), _edit(edit) {}

    inline void testRoot(const QString &sMsg) {
        _edit->appendPlainText("RootDataModel: " + sMsg);
    }
};

#endif // ROOTMODEL_H
