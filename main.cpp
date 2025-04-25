// main.cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    qputenv("QT_QPA_PLATFORM", "wayland");
    qputenv("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1");
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/main.qml"_qs);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
