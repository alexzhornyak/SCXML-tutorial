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

public slots:
    void process();
    void terminate();

signals:
    void finished();
    void fileFound(const QUrl &searchUrlDir, const QUrl &file);
    void scanCompleted(const QUrl &url, const QList<QUrl> &outList);

private:
    QUrl _searchUrlDir;
    QStringList _extensions;

    bool scanDir(const QDir &dir, QList<QUrl> &out);
};

#endif // FILESCANNER_H
