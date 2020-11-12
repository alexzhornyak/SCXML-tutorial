#include "filescanner.h"
#include <QDir>
#include <QDirIterator>
#include <QUrl>
#include <QThread>

FileScanner::FileScanner(const QUrl &searchUrlDir,
                         const QStringList &extensions,
                         QObject *parent) :
    QObject(parent), _searchUrlDir(searchUrlDir), _extensions(extensions)
{

}

void FileScanner::process()
{
    QStringList out;

    const QString folder = _searchUrlDir.toLocalFile();
    if (!folder.isEmpty()) {
        QDirIterator it(folder, _extensions,
                        QDir::Files, QDirIterator::Subdirectories);
        while (it.hasNext()) {

            if (this->thread()->isInterruptionRequested()) {
                break;
            }

            out << it.next();
            emit fileFound(_searchUrlDir, QUrl::fromLocalFile(out.last()));
        }

        emit scanCompleted(_searchUrlDir, out);
    }

    emit finished();
}

void FileScanner::terminate()
{
    this->thread()->requestInterruption();
}
