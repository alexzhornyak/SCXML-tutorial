#ifndef FILESCANNER_H
#define FILESCANNER_H

#include <QObject>
#include <QUrl>
#include <QDir>

class FileScanner : public QObject
{
    Q_OBJECT
public:
    explicit FileScanner(const QUrl &searchUrlDir,
                         const QStringList &extensions,
                         QObject *parent = nullptr);

    static QString convertFileNameToEscapedText(QString fileName);
    static QString getScanListName(const QUrl &url, const QStringList &extensions);

public slots:
    void process();
    void terminate();

signals:
    void finished();    
    void scanCompleted(const QUrl &url, const QList<QUrl> &outList);

private:
    QUrl _searchUrlDir;
    QStringList _extensions;

    bool scanDir(const QDir &dir, QStringList &out);
    bool loadScanList(QStringList &out);
};

#endif // FILESCANNER_H
