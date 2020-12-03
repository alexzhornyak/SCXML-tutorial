#include "filescanner.h"
#include <QDir>
#include <QDirIterator>
#include <QUrl>
#include <QThread>
#include <QCollator>

FileScanner::FileScanner(const QUrl &searchUrlDir,
                         const QStringList &extensions,
                         QObject *parent) :
    QObject(parent), _searchUrlDir(searchUrlDir), _extensions(extensions)
{

}

bool FileScanner::scanDir(const QDir &dir, QList<QUrl> &out) {

    if (this->thread()->isInterruptionRequested())
        return false;

    const auto &dirList = dir.entryInfoList(QStringList( "*" ),
                                           QDir::AllDirs | QDir::NoDot | QDir::NoDotAndDotDot | QDir::NoSymLinks,
                                           QDir::Name | QDir::IgnoreCase );
    for (auto itDir: dirList) {
        if (this->thread()->isInterruptionRequested())
            return false;

        if (!scanDir(itDir.absoluteFilePath(), out))
            return false;
    }

    const auto &fileList = dir.entryInfoList(_extensions,
                                          QDir::Files | QDir::NoDot | QDir::NoDotAndDotDot | QDir::NoSymLinks,
                                          QDir::Name | QDir::IgnoreCase | QDir::DirsFirst | QDir::Type );
    for (auto itFile: fileList) {
        if (this->thread()->isInterruptionRequested())
            return false;

        out << QUrl::fromLocalFile(itFile.absoluteFilePath());        
    }

    return true;
}

void FileScanner::process()
{
    QList<QUrl> out;

    if (scanDir(_searchUrlDir.toLocalFile(), out))
        emit scanCompleted(_searchUrlDir, out);

    emit finished();
}

void FileScanner::terminate()
{
    this->thread()->requestInterruption();
}


