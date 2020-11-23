#ifndef FILESCANNER_H
#define FILESCANNER_H

#include <QObject>
#include <QUrl>

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
    void scanCompleted(const QUrl &url, const QStringList &outList);

private:
    QUrl _searchUrlDir;
    QStringList _extensions;
};

#endif // FILESCANNER_H
