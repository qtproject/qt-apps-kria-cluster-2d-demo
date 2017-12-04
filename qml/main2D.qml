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
import QtQuick.Controls 2.1
import "./2D"

Item {
    id: mainview

    focus: true

    property bool startupAnimation: true
    property bool allowSelection: true

    property int contentIndex: 1
    property int previousContentIndex: 0
    property int maxContentIndex: 5

    property int selectedMenuIndex: 0
    property int maxMenuIndex: 5

    property int topZ: 1000
    // Settings
    property bool useMetric: true
    property bool redTheme: true
    property string esc: "On"
    property string trafficSigns: "Recognition"
    property string autoHighBeam: "On"
    property string hdLampDelay: "20 seconds"
    property string auxHeater: "On"
    property string parkHeater: "Time 2"
    property string chimesPark: "Off"
    property string chimesInfo: "Off"
    property string chimesWarning: "On"


    function resetGauges(shutdown) {
        mainview.startupAnimation = shutdown ? false : !mainview.startupAnimation;
        simuData.speed = 0;
        simuData.rpm = 0;
        simuData.speedAngle = simuData.angleOffset;
        simuData.tachoAngle = simuData.angleOffset
    }

    OverlayContainer {
        id: indicatorPane
        scale: mainview.width / 2560
        anchors.centerIn: mainview
        z: topZ

        Image {
            id: topLineImg
            width: 958; height: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.menuBottom
            anchors.topMargin: -10
            source: "qrc:/icons/2D/MenuTopLineCrop.png"
        }
        Image {
            id: bottomLineImg
            width: 958; height: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.tellTalesTop
            anchors.bottomMargin: 20
            source: "qrc:/icons/2D/MenuBottomLineCrop.png"
        }
    }

    Gauges {
        id: gauges
        z: topZ - 1
        state: "Driving"
        anchors.centerIn: mainview

        function setState(index) {
            if (index === 2) {
                state = "Navigation";
                content.item.fadeIn();
            } else {
                state = "Driving";
            }
        }

        onGaugeClicked: {
            resetGauges(false);
        }
    }

    Loader {
        id: content
        scale: mainview.width / 2560
        source: "qrc:/SettingsContainer.qml"
        anchors.centerIn: parent
        z: topZ - 2

        onSourceChanged: {
            gauges.setState(contentIndex);
        }
    }

    Keys.onRightPressed: {
        menuSelect(true);
    }

    Keys.onLeftPressed: {
        menuSelect(false);
    }

    Keys.onUpPressed: {
        selectedMenuIndex--;
        if (selectedMenuIndex < 0)
            selectedMenuIndex = 0;
    }

    Keys.onDownPressed: {
        selectedMenuIndex++;
        if (selectedMenuIndex > maxMenuIndex)
            selectedMenuIndex = maxMenuIndex;
    }

    onUseMetricChanged: {
        resetGauges(true);
    }

    // Simulated speed and rpm data
    SimuData {
        id: simuData
        startupAnimation: mainview.startupAnimation

        onTimeChanged: {
            indicatorPane.time.text = time;
        }
        onSpeedChanged: {
            gauges.speedText = speed;
        }
        onSpeedAngleChanged: {
            gauges.speedNeedle.speedNeedle.rotation = speedAngle;
        }
        onRpmChanged: {
            var rpmVal = (Math.round(rpm / 100) * 100) / 1000;
            gauges.tachoText = rpmVal.toFixed(1);
        }
        onTachoAngleChanged: {
            gauges.tachoNeedle.tachoNeedle.rotation = tachoAngle;
        }
    }

    function menuSelect(next) {
        if (!allowSelection)
            return;

        previousContentIndex = contentIndex;

        // settings - navigation - music - call - car
        if (next)
            contentIndex++;
        else
            contentIndex--;

        if (contentIndex > maxContentIndex)
            contentIndex = 1;
        else if (contentIndex < 1)
            contentIndex = maxContentIndex;

        selectContent(contentIndex);
    }

    function selectContent(index) {
        if (previousContentIndex === index)
            return;

        selectedMenuIndex = 0;
        indicatorPane.select(index);

        if (previousContentIndex === 2) { // from Navigation
            allowSelection = false;
            selectionTimer.start();
        } else if (previousContentIndex === 5) { // from Car
            allowSelection = false;
            selectionTimer.start();
        }

        switch (index) {
        case 1: // Settings
            content.source = "qrc:/SettingsContainer.qml";
            break;
        case 2: // Navigation
            allowSelection = false;
            selectionTimer.start();
            content.source = "qrc:/2D/Navigation.qml";
            break;
        case 3: // Music
            content.source = "qrc:/MusicContainer.qml";
            break;
        case 4: // Call
            content.source = "qrc:/ContactsContainer.qml";
            break;
        case 5: // Car
            allowSelection = false;
            selectionTimer.start();
            content.source = "qrc:/2D/CarContainer.qml";
            break;
        }
    }

    Timer {
        id: selectionTimer
        interval: 1000
        onTriggered: allowSelection = true;
    }
}
