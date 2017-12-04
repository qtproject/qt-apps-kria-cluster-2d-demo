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

import QtQuick 2.9

Item {
    id: simulation
    property int speed: 0
    property int rpm: 0

    property int turnSignal: Qt.NoArrow

    property var currentDate: new Date()
    property string time: currentDate.toLocaleTimeString(Qt.locale("en_EN"), "hh:mm")

    property bool startupAnimation: true

    property int angleOffset: -135
    property double speedAngle: -135
    property double tachoAngle: -135

    SequentialAnimation {
        id: animation
        running: startupAnimation
        loops: Animation.Infinite

        ParallelAnimation {
            PropertyAnimation {
                target: simulation
                property: "speed"
                from: 0
                to: useMetric ? 260: 140
                duration: 15000
                easing.type: Easing.InBounce
            }
            PropertyAnimation {
                target: simulation
                property: "speedAngle"
                from: angleOffset
                to: 100
                duration: 15000
                easing.type: Easing.InBounce
            }
            SequentialAnimation {
                ParallelAnimation {
                    PropertyAnimation {
                        target: simulation
                        property: "rpm"
                        from: 0
                        to: 3000
                        duration: 5000
                        easing.type: Easing.InOutSine
                    }
                    PropertyAnimation {
                        target: simulation
                        property: "tachoAngle"
                        from: angleOffset
                        to: -40
                        duration: 5000
                        easing.type: Easing.InOutSine
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: simulation
                        property: "rpm"
                        from: 3000
                        to: 5000
                        duration: 5000
                        easing.type: Easing.InOutSine
                    }
                    PropertyAnimation {
                        target: simulation
                        property: "tachoAngle"
                        from: -40
                        to: 26
                        duration: 5000
                        easing.type: Easing.InOutSine
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: simulation
                        property: "rpm"
                        from: 5000
                        to: 7000
                        duration: 5000
                        easing.type: Easing.InOutSine
                    }
                    PropertyAnimation {
                        target: simulation
                        property: "tachoAngle"
                        from: 26
                        to: 91
                        duration: 5000
                        easing.type: Easing.InOutSine
                    }
                }
            }
        }

        ParallelAnimation {
            PropertyAnimation {
                target: simulation
                property: "speed"
                from: useMetric ? 260: 140
                to: 0
                duration: 10000
                easing.type: Easing.OutBounce
            }
            PropertyAnimation {
                target: simulation
                property: "speedAngle"
                from: 100
                to: -135
                duration: 10000
                easing.type: Easing.OutBounce
            }
            SequentialAnimation {
                ParallelAnimation {
                    PropertyAnimation {
                        target: simulation
                        property: "rpm"
                        from: 7000
                        to: 5000
                        duration: 3000
                        easing.type: Easing.InOutSine
                    }
                    PropertyAnimation {
                        target: simulation
                        property: "tachoAngle"
                        from: 91
                        to: 26
                        duration: 3000
                        easing.type: Easing.InOutSine
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: simulation
                        property: "rpm"
                        from: 5000
                        to: 3000
                        duration: 3000
                        easing.type: Easing.InOutSine
                    }
                    PropertyAnimation {
                        target: simulation
                        property: "tachoAngle"
                        from: 26
                        to: -40
                        duration: 3000
                        easing.type: Easing.InOutSine
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: simulation
                        property: "rpm"
                        from: 3000
                        to: 0
                        duration: 4000
                        easing.type: Easing.InOutSine
                    }
                    PropertyAnimation {
                        target: simulation
                        property: "tachoAngle"
                        from: -40
                        to: angleOffset
                        duration: 4000
                        easing.type: Easing.InOutSine
                    }
                }
            }
        }
    }

    Timer {
        running: startupAnimation
        property bool turnLeft: true
        repeat: true
        interval: 5000
        onTriggered: {
            turnLeft = !turnLeft
            if (turnLeft)
                turnSignal = Qt.LeftArrow
            else
                turnSignal = Qt.RightArrow
            stopSignaling.start()
        }
    }

    Timer {
        id: stopSignaling
        running: false
        interval: 2100
        onTriggered: turnSignal = Qt.NoArrow
    }

    function updateTime() {
        currentDate = new Date();
        time = currentDate.toLocaleTimeString(Qt.locale("en_EN"), "hh:mm");
    }

    Timer {
        interval: 30000
        repeat: true
        running: true

        onTriggered: {
            updateTime();
        }
    }
}

