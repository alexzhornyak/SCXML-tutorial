#ifndef FILESCANNER_H
#define FILESCANNER_H

#include <QObject>

class FileScanner : public QObject
{
    Q_OBJECT
public:
    explicit FileScanner(const QString &sSearchUrlDir,
                         const QStringList &extensions,
                         QObject *parent = nullptr);

public slots:
    void process();
    void terminate();

signals:
    void finished();
    void fileFound(const QString &sSearchUrl, const QString &sFile);
    void scanCompleted(const QString &sUrl, const QStringList &outList);

private:
    QString _searchUrlDir;
    QStringList _extensions;
};

#endif // FILESCANNER_H
