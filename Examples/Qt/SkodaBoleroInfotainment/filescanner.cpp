#include "filescanner.h"
#include <QDir>
#include <QDirIterator>
#include <QUrl>
#include <QThread>

FileScanner::FileScanner(const QString &sSearchUrlDir,
                         const QStringList &extensions,
                         QObject *parent) :
    QObject(parent), _searchUrlDir(sSearchUrlDir), _extensions(extensions)
{

}

void FileScanner::process()
{
    QStringList out;

    QDirIterator it(QUrl(_searchUrlDir).toLocalFile(), _extensions,
                    QDir::Files, QDirIterator::Subdirectories);
    while (it.hasNext()) {

        if (this->thread()->isInterruptionRequested()) {
            break;
        }

        out << it.next();
        emit fileFound(_searchUrlDir, out.last());
    }

    emit scanCompleted(_searchUrlDir, out);

    emit finished();
}

void FileScanner::terminate()
{
    this->thread()->requestInterruption();
}
