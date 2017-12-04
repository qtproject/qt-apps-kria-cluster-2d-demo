TEMPLATE = app

QT += qml quick

target.path = $$[QT_INSTALL_EXAMPLES]/studio3d/$$TARGET
INSTALLS += target

SOURCES += main.cpp \
    fps.cpp

CONFIG += resources_big

RESOURCES += \
    kria-cluster-2d-demo.qrc \
    qml/telltales.qrc \
    qml/settings.qrc \
    qml/contacts.qrc \
    qml/music.qrc \
    qml/menu.qrc \
    qml/2d.qrc

OTHER_FILES += qml/*

RC_ICONS = example.ico

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    qmldir

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    fps.h
