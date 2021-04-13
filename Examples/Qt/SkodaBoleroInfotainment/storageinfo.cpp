#include "storageinfo.h"

StorageInfo::StorageInfo(QObject *parent) : QObject(parent)
{

}

bool StorageInfo::hasPath(const QUrl &url)
{
    auto file = url.toLocalFile();
    QFileInfo info(file);
    auto path = info.absolutePath();

    auto target = QStorageInfo(path).rootPath();
    auto source = _storage.rootPath();

    return source.toLower() == target.toLower();
}

QStringList StorageInfo::getMountedVolumes()
{
    QStringList out;
    const auto mountVolumes = QStorageInfo::mountedVolumes();
    for (const auto &it: mountVolumes) {
        out << it.rootPath();
    }
    return out;
}

void StorageInfo::setUrlPath(const QUrl &source) {
    _storage.setPath(source.toLocalFile());

    emit urlPathChanged();
}
