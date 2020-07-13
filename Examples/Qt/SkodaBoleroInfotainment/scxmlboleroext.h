#ifndef SCXMLBOLEROEXT_H
#define SCXMLBOLEROEXT_H

#include <QObject>

#include "bolero.h"

class ScxmlBoleroExt : public ScxmlBolero
{
    Q_OBJECT
    Q_PROPERTY(QVariant settings READ settings NOTIFY settingsChanged)

public:

    Q_INVOKABLE ScxmlBoleroExt(QObject *parent = 0);    

    QVariant settings();

signals:

    void settingsChanged(void);

private:

    static QString getSettingsFileName(void);

    bool loadSettings(QVariant &outSettings);
    bool saveSettings();

    const QString _literalSettings = "t_SETTINGS";
};

#endif // SCXMLBOLEROEXT_H
