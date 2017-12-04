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

OverlayContainerForm {
    id: indicatorContainer

    // Safety critical icons
    property bool parkBrake: startupAnimation ? true : false
    property bool flatTire: startupAnimation ? true : false
    property bool fuelLevel: startupAnimation ? true : false
    property bool seatbelt: startupAnimation ? true : false
    property bool oilLevel: startupAnimation ? true : false
    property bool brakeFailure: startupAnimation ? true : false

    onParkBrakeChanged: {
        parkingBrakeColor = parkBrake ? "#e41e25" : "#222324";
    }

    onFlatTireChanged: {
        tyreFailureColor = flatTire ? "#e6bd32" : "#222324";
    }

    onFuelLevelChanged: {
        fuelLowColor = fuelLevel ? "#e41e25" : "#222324";
    }

    onOilLevelChanged: {
        oilLowColor = oilLevel ? "#e41e25" : "#222324";
    }

    onSeatbeltChanged: {
        seatbeltOffColor = seatbelt ? "#e41e25" : "#222324";
    }

    onBrakeFailureChanged: {
        brakeFailureColor = brakeFailure ? "#e41e25" : "#222324";
    }

    // Non-safety critical indicators
    property int turnSignal: startupAnimation ? Qt.LeftArrow | Qt.RightArrow : simuData.turnSignal

    onTurnSignalChanged: {
        if (turnSignal !== Qt.NoArrow)
            signalTimer.restart();
        else
            signalTimer.stop();
        var turnLeft = (turnSignal & Qt.LeftArrow);
        var turnRight = (turnSignal & Qt.RightArrow);
        leftTurnSignalSource = turnLeft ? "qrc:/icons/icon_turnsignal_on.png"
                                        : "qrc:/icons/icon_turnsignal_off.png";
        rightTurnSignalSource = turnRight ? "qrc:/icons/icon_turnsignal_on.png"
                                          : "qrc:/icons/icon_turnsignal_off.png";
    }

    Timer {
        id: signalTimer
        interval: 500
        running: false
        repeat: true
        property bool flashing: false
        onTriggered: {
            flashing = !flashing
            var turnLeft = (flashing && (turnSignal & Qt.LeftArrow));
            var turnRight = (flashing && (turnSignal & Qt.RightArrow));
            leftTurnSignalSource = turnLeft ? "qrc:/icons/icon_turnsignal_on.png"
                                            : "qrc:/icons/icon_turnsignal_off.png";
            rightTurnSignalSource = turnRight ? "qrc:/icons/icon_turnsignal_on.png"
                                              : "qrc:/icons/icon_turnsignal_off.png";
        }
    }

    Component.onCompleted: {
        overlayBackground.visible = false;
        menuCar.scale = 0.75;
        menuCar.opacity = 0.5;
        menuNavigation.scale = 0.75;
        menuNavigation.opacity = 0.5;
        menuMusic.scale = 0.75;
        menuMusic.opacity = 0.5;
        menuCall.scale = 0.75;
        menuCall.opacity = 0.5;
    }

    function select(menuIndex) {
        // settings - navigation - music - call - car
        menuSettings.scale = 0.75;
        menuSettings.opacity = 0.5;
        menuCar.scale = 0.75;
        menuCar.opacity = 0.5;
        menuNavigation.scale = 0.75;
        menuNavigation.opacity = 0.5;
        menuMusic.scale = 0.75;
        menuMusic.opacity = 0.5;
        menuCall.scale = 0.75;
        menuCall.opacity = 0.5;

        switch (menuIndex) {
        case 1:
            menuSettings.scale = 1.0;
            menuSettings.opacity = 1.0;
            break;
        case 2:
            menuNavigation.scale = 1.0;
            menuNavigation.opacity = 1.0;
            break;
        case 3:
            menuMusic.scale = 1.0;
            menuMusic.opacity = 1.0;
            break;
        case 4:
            menuCall.scale = 1.0;
            menuCall.opacity = 1.0;
            break;
        case 5:
            menuCar.scale = 1.0;
            menuCar.opacity = 1.0;
            break;
        }
    }

    // Handle content button clicks
    mouseAreaSettings.onClicked: {
        previousContentIndex = contentIndex;
        contentIndex = 1;
        selectContent(1);
    }

    mouseAreaNavigation.onClicked: {
        previousContentIndex = contentIndex;
        contentIndex = 2;
        selectContent(2);
    }

    mouseAreaMusic.onClicked: {
        previousContentIndex = contentIndex;
        contentIndex = 3;
        selectContent(3);
    }

    mouseAreaCall.onClicked: {
        previousContentIndex = contentIndex;
        contentIndex = 4;
        selectContent(4);
    }

    mouseAreaCar.onClicked: {
        previousContentIndex = contentIndex;
        contentIndex = 5;
        selectContent(5);
    }
}
