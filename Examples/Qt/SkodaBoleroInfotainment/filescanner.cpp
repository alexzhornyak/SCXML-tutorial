#include "filescanner.h"

#include <QDebug>
#include <QDir>
#include <QDirIterator>
#include <QUrl>
#include <QThread>
#include <QRegularExpression>
#include <QGuiApplication>
#include <QTextStream>
#include <QTime>

FileScanner::FileScanner(const QUrl &searchUrlDir,
                         const QStringList &extensions,
                         QObject *parent) :
    QObject(parent), _searchUrlDir(searchUrlDir), _extensions(extensions)
{

}

QString FileScanner::convertFileNameToEscapedText(QString fileName) {
    fileName.replace(QRegularExpression("\\W+"), "");
    return fileName;
}

bool FileScanner::scanDir(const QDir &dir, QStringList &out) {

    const auto &dirList = dir.entryInfoList(QStringList( "*" ),
                                           QDir::AllDirs | QDir::NoDot | QDir::NoDotAndDotDot | QDir::NoSymLinks,
                                           QDir::Name | QDir::IgnoreCase );
    for (const auto &itDir: dirList) {
        if (this->thread()->isInterruptionRequested())
            return false;

        if (!scanDir(itDir.absoluteFilePath(), out))
            return false;
    }

    const auto &fileList = dir.entryInfoList(_extensions,
                                          QDir::Files | QDir::NoDot | QDir::NoDotAndDotDot | QDir::NoSymLinks,
                                          QDir::Name | QDir::IgnoreCase | QDir::DirsFirst | QDir::Type );

    for (const auto &itFile: fileList) {
        out << itFile.absoluteFilePath();
    }

    return true;
}

bool FileScanner::loadScanList(QStringList &out) {
    bool res = false;

    QFile inFileList(getScanListName(_searchUrlDir, _extensions));
    if (inFileList.exists()) {
        if (inFileList.open(QFile::ReadOnly | QFile::Text)) {

            QTextStream in(&inFileList);
            in.setCodec("UTF-8");
            int count = 0;
            while (!in.atEnd()) {
                count++;
                /* Take care not to call it too often, to keep the overhead low */
                if ((count % 1000 == 0) && this->thread()->isInterruptionRequested())
                    break;

                QString line = in.readLine();

                if (!line.isEmpty()) {
                    out << line;
                }
            }

            inFileList.close();

            res = true;
        }
    }

    return res;
}

void FileScanner::process()
{
    QStringList outPreset, outScan;
    const bool loadSuccess = loadScanList(outPreset);
    if (loadSuccess) {
        QList<QUrl> outUrls;
        for (const auto &it: outPreset) {
            outUrls << QUrl::fromLocalFile(it);
        }
        emit scanCompleted(_searchUrlDir, outUrls);
    }

    if (scanDir(_searchUrlDir.toLocalFile(), outScan)) {
        QList<QUrl> outUrls;

        QFile outFileList(getScanListName(_searchUrlDir, _extensions));
        if (outFileList.open(QFile::WriteOnly | QFile::Text)) {
            QTextStream outStream(&outFileList);
            outStream.setCodec("UTF-8");

            bool equal = loadSuccess && (outScan.size() == outPreset.size());

            for (int i=0;i<outScan.size();i++) {

                /* Take care not to call it too often, to keep the overhead low */
                if (i % 1000 == 0 && this->thread()->isInterruptionRequested())
                    break;

                const QString &filePath = outScan.at(i);

                outStream << filePath << "\n";
                outUrls << QUrl::fromLocalFile(filePath);
                if (equal) {
                    equal = filePath == outPreset.at(i);
                }

            }

            outFileList.close();

            if (!equal)
                emit scanCompleted(_searchUrlDir, outUrls);

        } else {
            qCritical() << "Can not save scan list! " << _searchUrlDir;
        }
    }

    emit finished();
}

void FileScanner::terminate()
{
    this->thread()->requestInterruption();
}

QString FileScanner::getScanListName(const QUrl &url, const QStringList &extensions) {
    const QString exts = FileScanner::convertFileNameToEscapedText(extensions.join("_"));
    const QString filePart =  "scanlist__" +
            FileScanner::convertFileNameToEscapedText(url.toLocalFile()) +
            "__" + exts + ".txt";

    const QString scanName =
            QDir(QGuiApplication::applicationDirPath()).filePath(filePart);

    return scanName;
}


