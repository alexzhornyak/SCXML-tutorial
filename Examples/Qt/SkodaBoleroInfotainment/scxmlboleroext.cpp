#include "scxmlboleroext.h"

#include <QGuiApplication>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QDir>

ScxmlBoleroExt::ScxmlBoleroExt(QObject *parent): ScxmlBolero(parent) {

    QVariant outSettings;
    if (loadSettings(outSettings)) {
        QVariantMap initials;
        initials.insert(_literalSettings, outSettings);
        setInitialValues(initials);
    }

    connectToState("end", [this](bool active){
        if (active) {
            saveSettings();
        }
    });

    connectToEvent("Out.SettingsChanged", [this](const QScxmlEvent &){
        emit settingsChanged();
    });
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

