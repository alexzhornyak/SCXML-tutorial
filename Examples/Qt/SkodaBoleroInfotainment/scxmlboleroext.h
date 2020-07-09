#ifndef SCXMLBOLEROEXT_H
#define SCXMLBOLEROEXT_H

#include <QObject>
#include "bolero.h"

class ScxmlBoleroExt : public ScxmlBolero
{
    Q_OBJECT

    static QString getSettingsFileName(void);

    bool loadSettings(void);
    bool saveSettings();

    const QString _literalSettings = "t_SETTINGS";

    QVariant _settings;

public:

    Q_INVOKABLE ScxmlBoleroExt(QObject *parent = 0);

};

#endif // SCXMLBOLEROEXT_H
