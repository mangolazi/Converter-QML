#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    //viewer.engine()->setOfflineStoragePath("E:/Converter");
    viewer.setMainQmlFile(QLatin1String("qml/Converter/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
