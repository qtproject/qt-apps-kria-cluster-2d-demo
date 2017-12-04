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
import QtQuick.Extras 1.4

Item {
    id: overlay
    width: 2560
    height: 960
    property alias mouseAreaSettings: mouseAreaSettings
    property alias mouseAreaNavigation: mouseAreaNavigation
    property alias mouseAreaMusic: mouseAreaMusic
    property alias mouseAreaCall: mouseAreaCall
    property alias mouseAreaCar: mouseAreaCar
    property alias time: time
    property alias menuCall: menuCall
    property alias menuMusic: menuMusic
    property alias menuNavigation: menuNavigation
    property alias menuCar: menuCar
    property alias menuSettings: menuSettings
    property alias rightTurnSignalSource: rightTurnSignal.source
    property alias oilLowColor: oilLow.color
    property alias fuelLowColor: fuelLow.color
    property alias tyreFailureColor: tyreFailure.color
    property alias brakeFailureColor: brakeFailure.color
    property alias parkingBrakeColor: parkingBrake.color
    property alias seatbeltOffColor: seatbeltOff.color
    property alias leftTurnSignalSource: leftTurnSignal.source
    property alias overlayBackground: overlayBackground
    property alias menuBottom: menu.bottom
    property alias tellTalesTop: telltalesRight.top

    Image {
        id: overlayBackground
        anchors.fill: parent
        source: "icons/QML_mask.jpg"
    }

    Row {
        id: telltalesLeft
        x: 649
        y: 872
        width: 500
        height: 80
        spacing: 62

        Image {
            id: leftTurnSignal
            width: 78
            height: 78
            fillMode: Image.Stretch
            source: "icons/icon_turnsignal_off.png"
        }

        Picture {
            id: seatbeltOff
            width: 78
            height: 78
            source: "qrc:/iso-icons/iso_grs_7000_4_0249.dat"
        }

        Picture {
            id: parkingBrake
            width: 78
            height: 78
            source: "qrc:/iso-icons/iso_grs_7000_4_0238.dat"
        }

        Picture {
            id: brakeFailure
            x: 280
            width: 78
            height: 78
            source: "qrc:/iso-icons/iso_grs_7000_4_0239.dat"
        }
    }

    Row {
        id: menu
        x: 907
        y: 19
        width: 747
        height: 95
        spacing: 68

        Image {
            id: menuSettings
            width: 95
            height: 95
            fillMode: Image.PreserveAspectFit
            source: "icons/settingsIcon.png"

            MouseArea {
                id: mouseAreaSettings
                anchors.fill: parent
                enabled: allowSelection
            }
        }

        Image {
            id: menuNavigation
            width: 95
            height: 95
            fillMode: Image.PreserveAspectFit
            source: "icons/navigationIcon.png"

            MouseArea {
                id: mouseAreaNavigation
                width: 95
                height: 95
                anchors.fill: parent
                enabled: allowSelection
            }
        }

        Image {
            id: menuMusic
            width: 95
            height: 95
            fillMode: Image.PreserveAspectFit
            source: "icons/musicIcon.png"

            MouseArea {
                id: mouseAreaMusic
                anchors.fill: parent
                enabled: allowSelection
            }
        }

        Image {
            id: menuCall
            width: 95
            height: 95
            fillMode: Image.PreserveAspectFit
            source: "icons/callIcon.png"

            MouseArea {
                id: mouseAreaCall
                anchors.fill: parent
                enabled: allowSelection
            }
        }
        Image {
            id: menuCar
            width: 95
            height: 95
            fillMode: Image.PreserveAspectFit
            source: "icons/carIcon.png"

            MouseArea {
                id: mouseAreaCar
                anchors.fill: parent
                enabled: allowSelection
            }
        }
    }

    Row {
        id: telltalesRight
        x: 1436
        y: 872
        width: 500
        height: 80
        spacing: 62

        Picture {
            id: tyreFailure
            width: 78
            height: 78
            source: "qrc:/iso-icons/iso_grs_7000_4_1434A.dat"
        }

        Picture {
            id: fuelLow
            width: 78
            height: 78
            source: "qrc:/iso-icons/iso_grs_7000_4_0245.dat"
        }

        Picture {
            id: oilLow
            width: 78
            height: 78
            source: "qrc:/iso-icons/iso_grs_7000_4_0248.dat"
        }

        Image {
            id: rightTurnSignal
            width: 78
            height: 78
            source: "icons/icon_turnsignal_off.png"
            rotation: 180
        }
    }

    Text {
        id: time
        x: 1220
        y: 883
        color: "#ffffff"
        text: qsTr("00:00")
        font.family: "Tahoma"
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 48
    }
}
