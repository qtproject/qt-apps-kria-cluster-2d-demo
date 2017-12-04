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

import QtQuick 2.7

MusicContainerForm {
    id: musicContainer

    property int album: selectedMenuIndex
    property string imageBgSrc: redTheme ? "qrc:/icons/musicBackground.png" :
                                           "qrc:/icons/musicBackgroundBlue.png"

    PropertyAnimation {
        id: progressAnimation
        duration: 60000
        running: true
        target: progressBar
        property: "value"
        from: 0.
        to: 1.
    }

    onAlbumChanged: {
        progressAnimation.restart();
        switch (album) {
        case 0:
            artistText = "Arch Enemy";
            albumText = "Will To Power";
            albumCoverSource = "qrc:/icons/album1.png";
            break;
        case 1:
            artistText = "Battle Beast";
            albumText = "Unholy Savior";
            albumCoverSource = "qrc:/icons/album2.png";
            break;
        case 2:
            artistText = "Machine Head";
            albumText = "Bloodstone & Diamonds";
            albumCoverSource = "qrc:/icons/album3.png";
            break;
        case 3:
            artistText = "Metallica";
            albumText = "Master of Puppets";
            albumCoverSource = "qrc:/icons/album4.png";
            break;
        case 4:
            artistText = "Sabaton";
            albumText = "Primo Victoria";
            albumCoverSource = "qrc:/icons/album5.png";
            break;
        case 5:
            artistText = "Sabaton";
            albumText = "The Last Stand";
            albumCoverSource = "qrc:/icons/album6.png";
            break;
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            selectedMenuIndex++;
            if (selectedMenuIndex > maxMenuIndex)
                selectedMenuIndex = 0;
        }
    }
}
