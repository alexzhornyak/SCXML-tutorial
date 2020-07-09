#include "scxmlboleroext.h"

#include <QGuiApplication>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QDir>

ScxmlBoleroExt::ScxmlBoleroExt(QObject *parent): ScxmlBolero(parent) {
    if (loadSettings()) {
        QVariantMap initials;
        initials.insert(_literalSettings, _settings);
        setInitialValues(initials);
    }
}

QString ScxmlBoleroExt::getSettingsFileName() {
    return QDir(QGuiApplication::applicationDirPath()).filePath("settings.json");
}

bool ScxmlBoleroExt::saveSettings() {
    if (this->dataModel()->hasScxmlProperty(_literalSettings)) {
        const QJsonValue ASettings = QJsonValue::fromVariant(this->dataModel()->scxmlProperty(_literalSettings));

        QFile AFile(getSettingsFileName());
        if (AFile.open(QIODevice::WriteOnly)) {
            QJsonDocument doc(ASettings.toObject());
            AFile.write(doc.toJson());
            return true;
        }
    }
    return false;
}

bool ScxmlBoleroExt::loadSettings(){
    QFile AFile(getSettingsFileName());
    if (AFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QJsonDocument doc = QJsonDocument::fromJson(AFile.readAll());
        if (!doc.isNull()) {
            _settings = doc.toVariant();
            return true;
        }

    }

    return true;
}

