#include "scxmlboleroext.h"

#include <QGuiApplication>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QDir>
#include <QDirIterator>
#include <QThread>

/* ScxmlJS */

void ScxmlJS::logD(const QString &sMessage) {
    qDebug() << "USER> " << sMessage;
}

void ScxmlJS::logW(const QString &sMessage) {
    qWarning() << "USER> " << " " << sMessage;
}

void ScxmlJS::logE(const QString &sMessage) {
    qCritical() << "USER> " << " " << sMessage;
}

/* ScxmlBoleroExt */

ScxmlBoleroExt::ScxmlBoleroExt(QObject *parent): ScxmlBolero(parent), _scxmlJS(new ScxmlJS(this)) {

    QVariantMap initials;

    QVariant outSettings;
    if (loadSettings(outSettings)) {        
        initials.insert(_literalSettings, outSettings);
    }

    initials.insert("_G", QVariant::fromValue(_scxmlJS));
    setInitialValues(initials);

    connectToState("end", [this](bool active){
        if (active) {
            saveSettings();
        }
    });

    connectToEvent("Out.SettingsChanged", [this](const QScxmlEvent &){
        emit settingsChanged();
    });
}

bool ScxmlBoleroExt::fileExists(const QString &sFile) {
    return QFile::exists(sFile);
}

bool ScxmlBoleroExt::fileDelete(const QString &sFile) {
    return QFile::remove(sFile);
}

bool ScxmlBoleroExt::fileCopy(const QString &sSource, const QString &sTarget) {
    return QFile::copy(sSource, sTarget);
}

QString ScxmlBoleroExt::urlToLocalFile(const QString &sUrl) {
    return QUrl(sUrl).toLocalFile();
}

bool ScxmlBoleroExt::urlDirExists(const QString &sUrl) {
    QFileInfo info(QUrl(sUrl).toLocalFile());
    return info.isRoot() || info.isDir();
}

void ScxmlBoleroExt::terminateScanDir(const QString &sUrl)
{
    auto it = _audioFileScanners.find(sUrl);
    if (it!=_audioFileScanners.end()) {
        it.value()->terminate();
    }
}

void ScxmlBoleroExt::scanDirAsync(const QString &sUrl, const QStringList &extensions) {
    if (_audioFileScanners.find(sUrl)==_audioFileScanners.end()) {
        FileScanner *scanner = new FileScanner(sUrl, extensions);
        QThread *thread = new QThread;
        scanner->moveToThread(thread);

        _audioFileScanners.insert(sUrl, scanner);

        connect(thread, SIGNAL(started()), scanner, SLOT(process()));
        connect(scanner, SIGNAL(finished()), thread, SLOT(quit()));
        connect(scanner, SIGNAL(finished()), scanner, SLOT(deleteLater()));
        connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));

#if 0 // optional file by file search
        connect(scanner, SIGNAL(fileFound(const QString&, const QString&)),
                this, SLOT(onFileFound(const QString&, const QString&)));
#endif
        connect(scanner, SIGNAL(scanCompleted(const QString&, const QStringList&)),
                this, SLOT(onScanCompleted(const QString&, const QStringList&)));

        thread->start();
    }
}


void ScxmlBoleroExt::onScanCompleted(const QString &sUrl, const QStringList &outList) {
    _audioFileScanners.remove(sUrl);

    emit mediaScanCompleted(sUrl, outList);
}

QVariant ScxmlBoleroExt::settings() {
    auto dm = this->dataModel();
    if (dm && dm->hasScxmlProperty(_literalSettings)) {
        return this->dataModel()->scxmlProperty(_literalSettings);
    }
    return QVariant();
}

QString ScxmlBoleroExt::getSettingsFileName() {
    return QDir(QGuiApplication::applicationDirPath()).filePath("settings.json");
}

bool ScxmlBoleroExt::saveSettings(void) {
    auto dm = this->dataModel();
    if (dm && dm->hasScxmlProperty(_literalSettings)) {
        const QJsonValue jsonSettings = QJsonValue::fromVariant(this->dataModel()->scxmlProperty(_literalSettings));

        QFile AFile(getSettingsFileName());
        if (AFile.open(QIODevice::WriteOnly)) {
            QJsonDocument doc(jsonSettings.toObject());
            AFile.write(doc.toJson());
            return true;
        }
    }
    return false;
}

bool ScxmlBoleroExt::loadSettings(QVariant &outSettings){
    QFile AFile(getSettingsFileName());
    if (AFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QJsonDocument doc = QJsonDocument::fromJson(AFile.readAll());
        if (!doc.isNull()) {
            outSettings = doc.toVariant();
            return true;
        }

    }

    return true;
}
