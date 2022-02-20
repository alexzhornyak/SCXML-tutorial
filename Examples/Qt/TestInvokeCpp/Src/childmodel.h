#ifndef CHILDMODEL_H
#define CHILDMODEL_H

#include <QScxmlCppDataModel>
#include <QPlainTextEdit>

class ChildDataModel: public QScxmlCppDataModel
{
    Q_OBJECT
    Q_SCXML_DATAMODEL

    QPlainTextEdit *_edit = nullptr;
public:
    ChildDataModel(QPlainTextEdit *edit, QObject *parent = nullptr):
        QScxmlCppDataModel(parent), _edit(edit) {}

    inline void testChild(const QString &sMsg) {
        _edit->appendPlainText("ChildDataModel: " + sMsg);
    }
};

#endif // CHILDMODEL_H
