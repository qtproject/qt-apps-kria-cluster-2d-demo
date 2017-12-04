/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Kria Cluster 2D Demo.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include <QtGui/qguiapplication.h>
#include <QtCore/qdir.h>
#include <QtQuick/qquickview.h>
#include <QtQml/qqmlengine.h>
#include <QtGui/qfontdatabase.h>

#include "fps.h"

int main(int argc, char *argv[])
{
    qputenv("QT_QPA_EGLFS_WIDTH", "1920");
    qputenv("QT_QPA_EGLFS_HEIGHT", "720");
    qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH", "1920");
    qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT", "720");

    QGuiApplication app(argc, argv);

    qmlRegisterType<FPS>("FPS", 1, 0, "FPS");

    QQuickView viewer;

    QFontDatabase::addApplicationFont("qrc:/qml/fonts/TitilliumWeb-SemiBold.ttf");
    QFont defaultFont;
    defaultFont.setFamily("Titillium Web");
    QGuiApplication::setFont(defaultFont);

    viewer.setSource(QUrl("qrc:/main2D.qml"));

    viewer.setTitle(QStringLiteral("Kria Cluster 2D Demo"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setWidth(1920);
    viewer.setHeight(720);
    viewer.setColor(QColor("black"));
    viewer.show();

    return app.exec();
}
