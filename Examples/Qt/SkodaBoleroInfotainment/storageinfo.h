#ifndef STORAGEINFO_H
#define STORAGEINFO_H

#include <QObject>
#include <QStorageInfo>
#include <QUrl>

class StorageInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl urlPath READ urlPath WRITE setUrlPath NOTIFY urlPathChanged)
    Q_PROPERTY(bool enabled READ isEnabled NOTIFY enabledChanged)
public:
    explicit StorageInfo(QObject *parent = nullptr);

    Q_INVOKABLE bool hasPath(const QUrl &url);
    Q_INVOKABLE QStringList getMountedVolumes();

protected:
    inline QUrl urlPath() const { return QUrl::fromLocalFile(_storage.rootPath()); }
    void setUrlPath(const QUrl &source);

    inline bool isEnabled() const { return _storage.isReady() && _storage.isValid(); }
signals:
    void urlPathChanged();
    void enabledChanged();
private:
    QStorageInfo _storage;
};

#endif // STORAGEINFO_H
