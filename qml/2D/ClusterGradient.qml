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
import QtGraphicalEffects 1.0

Item {
    id: root

    width: 100
    height: 100

    property double topAndBottomCurtainHeight: 100
    property double leftAndRightCurtainWidth: 100

    property double topGradientHeight: 200
    property double leftGradientWidth: 700
    property double rightGradientWidth: 300
    property double bottomGradientHeight: 100

    property string curtainColor: "black"
    property string gradientStartColor: "black"
    property string gradientStopColor: "transparent"

    property double gradientTopStopPoint: 0.5
    property double gradientLeftStopPoint: 0.6
    property double gradientRightStopPoint: 0.8
    property double gradientBottomStopPoint: 0.8

    function fadeIn() {
        fadeInAnimation.start();
    }
    function fadeOut() {
        fadeOutAnimation.start();
    }

    // Top gradient
    Rectangle {
        id: top
        anchors.top: parent.top
        width: parent.width
        height: topAndBottomCurtainHeight
        color: curtainColor

        LinearGradient {
            width: parent.width
            height: topGradientHeight
            anchors.top: parent.bottom
            start: Qt.point(0, 0)
            end: Qt.point(0, height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: gradientStartColor }
                GradientStop { position: gradientTopStopPoint; color: gradientStopColor }
            }
        }
    }

    // Left gradient
    Rectangle {
        id: left
        width: leftAndRightCurtainWidth
        height: parent.height
        anchors.left: parent.left
        color: curtainColor

        LinearGradient {
            width: leftGradientWidth
            height: parent.height
            anchors.left: parent.right
            start: Qt.point(0, 0)
            end: Qt.point(width, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: gradientStartColor }
                GradientStop { position: gradientLeftStopPoint; color: gradientStopColor }
            }
        }
    }

    // Right gradient
    Rectangle {
        id: right
        width: leftAndRightCurtainWidth
        height: parent.height
        anchors.right: parent.right
        color: curtainColor

        LinearGradient {
            width: rightGradientWidth
            height: parent.height
            anchors.right: parent.left
            start: Qt.point(0, 0)
            end: Qt.point(width, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: gradientStopColor }
                GradientStop { position: gradientRightStopPoint; color: gradientStartColor }
            }
        }
    }

    // Bottom gradient
    Rectangle {
        id: bottom
        width: parent.width
        height: topAndBottomCurtainHeight
        anchors.bottom: parent.bottom
        color: curtainColor

        LinearGradient {
            width: parent.width
            height: bottomGradientHeight
            anchors.bottom: parent.top
            start: Qt.point(0, 0)
            end: Qt.point(0, height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: gradientStopColor }
                GradientStop { position: gradientBottomStopPoint; color: gradientStartColor }
            }
        }
    }

    Rectangle {
        id: viewFiller
        anchors.fill: parent
        opacity: 1.0
        color: "black"
    }

    SequentialAnimation {
        id: fadeInAnimation
        running: false
        loops: 1

        PauseAnimation { duration: 300 }
        ParallelAnimation {
            PropertyAnimation {
                target: viewFiller
                properties: "opacity"
                from: 1.0
                to: 0.0
                duration: 300
            }
        }
    }
    SequentialAnimation {
        id: fadeOutAnimation
        running: false
        loops: 1

        PauseAnimation { duration: 300 }
        ParallelAnimation {
            PropertyAnimation {
                target: viewFiller
                properties: "opacity"
                from: 0.0
                to: 1.0
                duration: 300
            }
        }
    }
}
