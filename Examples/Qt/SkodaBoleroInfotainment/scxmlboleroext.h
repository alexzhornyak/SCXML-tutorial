#ifndef SCXMLBOLEROEXT_H
#define SCXMLBOLEROEXT_H

#include <QObject>

#include "bolero.h"
#include "filescanner.h"

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

    Q_INVOKABLE bool fileDelete(const QString &sFile);

    Q_INVOKABLE bool fileCopy(const QString &sSource, const QString &sTarget);

    Q_INVOKABLE QString urlToLocalFile(const QString &sUrl);

    Q_INVOKABLE bool urlDirExists(const QString &sUrl);

    Q_INVOKABLE void scanDirAsync(const QString &sUrl, const QStringList &extensions);

    Q_INVOKABLE void terminateScanDir(const QString &sUrl);

    QVariant settings();    

signals:

    void settingsChanged(void);

    void mediaScanCompleted(const QString &sUrl, const QStringList &outList);

public slots:

    void onScanCompleted(const QString &sUrl, const QStringList &outList);

private:

    static QString getSettingsFileName(void);

    bool loadSettings(QVariant &outSettings);
    bool saveSettings();

    const QString _literalSettings = "t_SETTINGS";

    ScxmlJS *_scxmlJS = nullptr;

    QMap<QString,FileScanner*> _audioFileScanners;
};

#endif // SCXMLBOLEROEXT_H
