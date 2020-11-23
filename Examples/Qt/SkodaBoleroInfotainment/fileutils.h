#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>
#include <QUrl>
#include <QMap>

#include "filescanner.h"

class FileUtils : public QObject
{
    Q_OBJECT

public:

    Q_INVOKABLE FileUtils(QObject *parent = nullptr);

    Q_INVOKABLE bool fileExists(const QString &sFile);

    Q_INVOKABLE bool fileDelete(const QString &sFile);

    Q_INVOKABLE bool fileCopy(const QString &sSource, const QString &sTarget);

    Q_INVOKABLE QString urlToLocalFile(const QUrl &url);

    Q_INVOKABLE QUrl urlFromLocalFile(const QString &url);

    Q_INVOKABLE bool urlExists(const QUrl &url);

    Q_INVOKABLE QUrl urlExtractPath(const QUrl &url);

    Q_INVOKABLE QString urlExtractFileName(const QUrl &url);

    Q_INVOKABLE void scanDirAsync(const QUrl &url, const QStringList &extensions);
    Q_INVOKABLE void terminateScanDir(const QUrl &url);

signals:

    void mediaScanCompleted(const QUrl &url, const QStringList &outList);

public slots:

    void onScanCompleted(const QUrl &url, const QStringList &outList);

private:

    QMap<QUrl,FileScanner*> _audioFileScanners;
};

#endif // FILEUTILS_H
