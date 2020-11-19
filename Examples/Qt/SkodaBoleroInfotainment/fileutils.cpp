#include "fileutils.h"

#include <QFile>
#include <QDir>
#include <QDirIterator>
#include <QThread>

FileUtils::FileUtils(QObject *parent) : QObject(parent) {

}

bool FileUtils::fileExists(const QString &sFile) {
    return QFile::exists(sFile);
}

bool FileUtils::fileDelete(const QString &sFile) {
    return QFile::remove(sFile);
}

bool FileUtils::fileCopy(const QString &sSource, const QString &sTarget) {
    return QFile::copy(sSource, sTarget);
}

QUrl FileUtils::urlFromLocalFile(const QString &url) {
    return QUrl::fromLocalFile(url);
}

QString FileUtils::urlToLocalFile(const QUrl &url) {
    return url.toLocalFile();
}

bool FileUtils::urlExists(const QUrl &url) {
    return QFileInfo::exists(url.toLocalFile());
}

QUrl FileUtils::urlExtractPath(const QUrl &url) {
    return QUrl::fromLocalFile(QFileInfo(url.toLocalFile()).absolutePath());
}

QString FileUtils::urlExtractFileName(const QUrl &url) {
    return url.fileName();
}

void FileUtils::terminateScanDir(const QUrl &url)
{
    auto it = _audioFileScanners.find(url);
    if (it!=_audioFileScanners.end()) {
        it.value()->terminate();
    }
}

void FileUtils::scanDirAsync(const QUrl &url, const QStringList &extensions) {
    if (_audioFileScanners.find(url)==_audioFileScanners.end()) {
        FileScanner *scanner = new FileScanner(url, extensions);
        QThread *thread = new QThread;
        scanner->moveToThread(thread);

        _audioFileScanners.insert(url, scanner);

        connect(thread, SIGNAL(started()), scanner, SLOT(process()));
        connect(scanner, SIGNAL(finished()), thread, SLOT(quit()));
        connect(scanner, SIGNAL(finished()), scanner, SLOT(deleteLater()));
        connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));

#if 0 // optional file by file search
        connect(scanner, SIGNAL(fileFound(const QString&, const QString&)),
                this, SLOT(onFileFound(const QString&, const QString&)));
#endif
        connect(scanner, SIGNAL(scanCompleted(const QUrl&, const QStringList&)),
                this, SLOT(onScanCompleted(const QUrl&, const QStringList&)));

        thread->start();
    }
}


void FileUtils::onScanCompleted(const QUrl &url, const QStringList &outList) {
    _audioFileScanners.remove(url);

    emit mediaScanCompleted(url, outList);
}
