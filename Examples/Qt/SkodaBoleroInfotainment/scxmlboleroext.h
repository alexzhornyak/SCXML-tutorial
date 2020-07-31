#ifndef SCXMLBOLEROEXT_H
#define SCXMLBOLEROEXT_H

#include <QObject>

#include "bolero.h"

class ScxmlJS: public QObject {
    Q_OBJECT
public:
    Q_INVOKABLE ScxmlJS(QObject *parent = nullptr):QObject(parent) {
    }
    virtual ~ScxmlJS() {}

    Q_INVOKABLE void logD(const QString &sMessage);
    Q_INVOKABLE void logW(const QString &sMessage);
    Q_INVOKABLE void logE(const QString &sMessage);
};


class ScxmlBoleroExt : public ScxmlBolero
{
    Q_OBJECT
    /* access only from State Machine DataModel */
    Q_PROPERTY(QVariant settings READ settings NOTIFY settingsChanged)

public:

    Q_INVOKABLE ScxmlBoleroExt(QObject *parent = nullptr);

    Q_INVOKABLE bool fileExists(const QString &sFile);

    QVariant settings();    

signals:

    void settingsChanged(void);

private:

    static QString getSettingsFileName(void);

    bool loadSettings(QVariant &outSettings);
    bool saveSettings();

    const QString _literalSettings = "t_SETTINGS";

    ScxmlJS *_scxmlJS = nullptr;
};

#endif // SCXMLBOLEROEXT_H
