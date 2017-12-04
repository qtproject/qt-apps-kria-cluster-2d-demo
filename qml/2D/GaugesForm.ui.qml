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

Item {
    id: root

    property alias tachoMeter: tachoMeter
    property alias speedMeter: speedMeter

    property alias tachoText: tachoText.text
    property alias speedText: speedText.text

    property alias tachoNeedleRpm: tachoNeedle.vehicleRpm
    property alias speedNeedleSpeed: speedNeedle.vehicleSpeed

    property alias tachoNumRect: tachoNumRect
    property alias speedNumRect: speedNumRect
    property alias tachoCorner: tachoCorner
    property alias speedCorner: speedCorner
    property alias tachoNeedle: tachoNeedle
    property alias speedNeedle: speedNeedle
    property alias speedImage: speedImage

    width: 1920
    height: 720

    Item {
        id: tachoMeter
        width: 612
        height: width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: tachoImage
            x: 0
            y: 0
            width: parent.width
            height: width
            source: tachoImageSrc
            visible: true
        }
    } // tachoMeter

    Rectangle {
        id: tachoNumRect
        x: 216
        y: 270
        width: 180
        height: width
        color: "#000000"
        radius: width

        Text {
            id: tachoText
            color: "#ffffff"
            anchors.horizontalCenterOffset: 0
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 60
        }
        Text {
            id: tachoUnitText
            color: "#ffffff"
            text: root.tachoUnit
            anchors.horizontalCenterOffset: -35
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            anchors.top: tachoText.bottom
            anchors.topMargin: -5
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20
        }
        Text {
            id: tachoUnitSpecText
            color: "#ffffff"
            text: root.tachoUnitSpec
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenter: tachoUnitText.verticalCenter
            anchors.left: tachoUnitText.right
            anchors.rightMargin: 2
            font.pixelSize: 20
        }
        z: 1000
    }
    TachoNeedle {
        id: tachoNeedle
        x: 0
        y: 25
        width: 612
        height: width
        z: tachoNumRect.z - 1
    }
    Rectangle {
        id: tachoCorner
        scale: 3.0
        opacity: 0.0
        x: 212
        y: 266
        width: tachoNumRect.width + 8
        height: width
        radius: width
        color: "transparent"
        border.color: "white"
        border.width: 7
    }

    Item {
        id: speedMeter
        x: 1440
        width: 612
        height: width
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: speedImage
            x: 0
            y: 0
            width: parent.width
            height: width
            source: speedImageSrc
            visible: true
        }
    } // speedMeter

    Rectangle {
        id: speedNumRect
        x: 1524
        y: 270
        width: 180
        height: width
        radius: width
        color: "#000000"

        Text {
            id: speedText
            x: 150
            color: "#ffffff"
            anchors.horizontalCenterOffset: 0
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 60
        }
        Text {
            id: speedUnitText
            x: 150
            color: "#ffffff"
            text: root.speedUnit
            anchors.horizontalCenterOffset: 0
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            anchors.top: speedText.bottom
            anchors.topMargin: -5
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20
        }

        z: 1000
    }
    SpeedNeedle {
        id: speedNeedle
        x: 654
        y: 25
        width: 612
        height: width
        z: speedNumRect.z - 1
    }
    Rectangle {
        id: speedCorner
        scale: 3.0
        opacity: 0.0
        x: 1520
        y: 266
        width: speedNumRect.width + 8
        height: width
        radius: width
        color: "transparent"
        border.color: "white"
        border.width: 7
    }
}
