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

GaugesForm {
    id: root

    property string tachoUnit: "rpm"
    property string tachoUnitSpec: " x 1000"
    property string speedUnit: useMetric ? "kph" : "mph"
    property string needleSrc: "qrc:/icons/2D/NeedleBg.png"
    property string tachoImageSrc: redTheme ? "qrc:/icons/2D/TachoMeterBg.png" :
                                              "qrc:/icons/2D/TachoMeterBgBlue.png"
    property string kphSpeedImageSrc: redTheme ? "qrc:/icons/2D/SpeedMeterBg.png" :
                                                 "qrc:/icons/2D/SpeedMeterBgBlue.png"
    property string mphSpeedImageSrc: redTheme ? "qrc:/icons/2D/MphSpeedMeterBg.png" :
                                                 "qrc:/icons/2D/MphSpeedMeterBgBlue.png"
    property string speedImageSrc: useMetric ? kphSpeedImageSrc : mphSpeedImageSrc

    property int vehicleSpeed: 0
    property int vehicleRpm: 0

    property int slowDuration: 500
    property int fastDuration: 100

    signal gaugeClicked()

    Component.onCompleted: {
        speedNeedleSpeed = vehicleSpeed;
        tachoText = vehicleSpeed;
        speedText = vehicleSpeed;
    }

    Behavior on speedUnit {
        SequentialAnimation {
            NumberAnimation {
                target: speedImage
                properties: "scale"
                to: 0.3
                duration: fastDuration
            }
            NumberAnimation {
                target: speedImage
                properties: "scale"
                to: 1.0
                duration: slowDuration
            }
        }
    }

    MouseArea {
        id: tachoMouse
        anchors.fill: tachoNumRect
        onClicked: { root.gaugeClicked(); }
    }

    MouseArea {
        id: speedMouse
        anchors.fill: speedNumRect
        onClicked: { root.gaugeClicked(); }
    }

    states: [
        State {
            name: "Driving";

            AnchorChanges {
                target: tachoMeter
                anchors.left: root.left
                anchors.verticalCenter: root.verticalCenter
            }
            PropertyChanges {
                target: tachoMeter
                anchors.verticalCenterOffset: 0
                anchors.rightMargin: 0
            }
            AnchorChanges {
                target: speedMeter
                anchors.right: root.right
                anchors.verticalCenter: root.verticalCenter
            }
            PropertyChanges {
                target: speedMeter
                anchors.verticalCenterOffset: 0
                anchors.leftMargin: 0
            }
        },
        State {
            name: "Navigation";

            AnchorChanges {
                target: tachoMeter
                anchors.left: root.left
                anchors.verticalCenter: root.verticalCenter
            }
            PropertyChanges {
                target: tachoMeter
                anchors.verticalCenterOffset: 253
                anchors.leftMargin: -100
            }
            AnchorChanges {
                target: speedMeter
                anchors.right: root.right
                anchors.verticalCenter: root.verticalCenter
            }
            PropertyChanges {
                target: speedMeter
                anchors.verticalCenterOffset: 253
                anchors.rightMargin: -100
            }
        }
    ]

    transitions: [
        Transition {
            from:"Driving"
            to: "Navigation"
            SequentialAnimation {
                ParallelAnimation {
                    PropertyAnimation {
                        target: tachoNeedle
                        properties: "opacity"
                        from: 1.0
                        to: 0.0
                        duration: fastDuration
                    }
                    PropertyAnimation {
                        target: speedNeedle
                        properties: "opacity"
                        from: 1.0
                        to: 0.0
                        duration: fastDuration
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: tachoCorner
                        properties: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: speedCorner
                        properties: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: tachoMeter
                        properties: "scale"
                        from: 1.0
                        to: 0.3
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: speedMeter
                        properties: "scale"
                        from: 1.0
                        to: 0.3
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: tachoCorner
                        properties: "scale"
                        from: 3.0
                        to: 1.0
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: speedCorner
                        properties: "scale"
                        from: 3.0
                        to: 1.0
                        duration: slowDuration
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: tachoNumRect
                        properties: "x"
                        from: 216
                        to: 116
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: tachoNumRect
                        properties: "y"
                        from: 270
                        to: 520
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: speedNumRect
                        properties: "x"
                        from: 1524
                        to: 1624
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: speedNumRect
                        properties: "y"
                        from: 270
                        to: 520
                        duration: slowDuration
                    }
                    // Corners
                    PropertyAnimation {
                        target: tachoCorner
                        properties: "x"
                        from: 212
                        to: 112
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: tachoCorner
                        properties: "y"
                        from: 266
                        to: 516
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: speedCorner
                        properties: "x"
                        from: 1520
                        to: 1620
                        duration: slowDuration
                    }
                    PropertyAnimation {
                        target: speedCorner
                        properties: "y"
                        from: 266
                        to: 516
                        duration: slowDuration
                    }
                    AnchorAnimation { duration: slowDuration }
                    PropertyAnimation {
                        target: tachoMeter
                        properties: "scale"
                        from: 0.3
                        to: 0.0
                        duration: 2*slowDuration
                    }
                    PropertyAnimation {
                        target: speedMeter
                        properties: "scale"
                        from: 0.3
                        to: 0.0
                        duration: 2*slowDuration
                    }
                }
            }
        },
        Transition {
            from: "Navigation"
            to: "Driving"
            SequentialAnimation {
                ParallelAnimation {
                    PropertyAnimation {
                      target: tachoNumRect
                      properties: "x"
                      from: 116
                      to: 216
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: tachoNumRect
                      properties: "y"
                      from: 520
                      to: 270
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: speedNumRect
                      properties: "x"
                      from: 1624
                      to: 1524
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: speedNumRect
                      properties: "y"
                      from: 520
                      to: 270
                      duration:slowDuration
                    }
                    // Corners
                    PropertyAnimation {
                      target: tachoCorner
                      properties: "x"
                      from: 112
                      to: 212
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: tachoCorner
                      properties: "y"
                      from: 516
                      to: 266
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: speedCorner
                      properties: "x"
                      from: 1620
                      to: 1520
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: speedCorner
                      properties: "y"
                      from: 516
                      to: 266
                      duration: slowDuration
                    }
                    AnchorAnimation { duration: slowDuration }
                    PropertyAnimation {
                      target: tachoMeter
                      properties: "scale"
                      from: 0.0
                      to:0.3
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: speedMeter
                      properties: "scale"
                      from: 0.0
                      to: 0.3
                      duration: slowDuration
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                      target: tachoMeter
                      properties: "scale"
                      from: 0.3
                      to: 1.0
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: speedMeter
                      properties: "scale"
                      from: 0.3
                      to: 1.0
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: tachoCorner
                      properties: "scale"
                      from: 1.0
                      to: 3.0
                      duration: slowDuration
                    }
                    PropertyAnimation {
                      target: speedCorner
                      properties: "scale"
                      from: 1.0
                      to: 3.0
                      duration: slowDuration
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                      target: tachoNeedle
                      properties: "opacity"
                      from: 0.0
                      to: 1.0
                      duration: fastDuration
                    }
                    PropertyAnimation { target: speedNeedle
                      properties: "opacity"
                      from: 0.0
                      to: 1.0
                      duration: fastDuration
                    }
                    PropertyAnimation {
                      target: tachoCorner
                      properties: "opacity"
                      from: 1.0
                      to: 0.0
                      duration: fastDuration
                    }
                    PropertyAnimation {
                      target: speedCorner
                      properties: "opacity"
                      from: 1.0
                      to: 0.0
                      duration: fastDuration
                    }
                }
            }
        }
    ]
}
