#include "storageinfo.h"

StorageInfo::StorageInfo(QObject *parent) : QObject(parent)
{

}

bool StorageInfo::hasPath(const QUrl &url)
{
    auto file = url.toLocalFile();
    QFileInfo info(file);
    auto path = info.absolutePath();
    //info.dir().a

    auto target = QStorageInfo(path).rootPath();
    auto source = _storage.rootPath();

    return source == target;
}

QStringList StorageInfo::getMountedVolumes()
{
    QStringList out;
    for (auto it: QStorageInfo::mountedVolumes()) {
        out << it.rootPath();
    }
    return out;
}

void StorageInfo::setUrlPath(const QUrl &source) {
    _storage.setPath(source.toLocalFile());

    emit urlPathChanged();
}
