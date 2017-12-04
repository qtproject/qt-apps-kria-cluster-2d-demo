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
import "./listmodels"

SettingsContainerForm {
    id: settingsContainer

    property string imageBgSrc: redTheme ? "qrc:/icons/RedHighlight.png" :
                                           "qrc:/icons/BlueHighlight.png"
    property string menuBackSrc: redTheme ? "qrc:/icons/MenuBack.png" :
                                            "qrc:/icons/MenuBackBlue.png"
    property var modelMap: ({ 0:displayModel, 1: daModel, 2: lightningModel,
                                3: chimesModel, 4: convenienceModel })
    property var previousModel: mainModel
    property int subMenuLevel: 0
    property string currentSetting: ""
    property string currentSubSetting: ""

    onSubMenuLevelChanged: {
        if (subMenuLevel === 0) {
            setMainMenu();
            highlightSpeed = 600;
        } else if (subMenuLevel === 1) {
            currentSubSetting = "";
            listview.model = previousModel;
            titleText = currentSetting;
            highlightSpeed = 200;
        }
    }
    onCurrentSettingChanged: {
        titleText = currentSetting;
    }
    onCurrentSubSettingChanged: {
        titleText = currentSubSetting;
    }

    function handleMenu() {
        if (subMenuLevel === 0) {
            setMenu(selectedMenuIndex);
            // Reset selectedMenuIndex
            selectedMenuIndex = 0;
        } else if (subMenuLevel === 1) {
            handleSubMenu(selectedMenuIndex);
            // Reset selectedMenuIndex
            selectedMenuIndex = 0;
        } else {
            handleAction(selectedMenuIndex);
        }
    }
    function setMainMenu() {
        listview.model = mainModel;
        titleText = qsTr("Settings");
    }
    function setMenu(selectedIndex) {
        if (selectedIndex === listview.count - 1) {
            helpItem.visible = true;
        } else {
            currentSetting = listview.model.get(selectedIndex).name;
            previousModel = modelMap[selectedMenuIndex];
            subMenuLevel++;
        }
    }
    function handleSubMenu(selectedIndex) {
        if (selectedIndex === listview.count - 1) {
            subMenuLevel--;
        } else {
            appendMenuActions(selectedIndex);
            subMenuLevel++;
        }
    }
    function appendMenuActions(selectedIndex) {
        if (listview.model === displayModel) {
            if (selectedIndex === 0) {
                listview.model = displayColorModel
            } else {
                listview.model = displayUnitModel
            }
        } else if (listview.model === daModel) {
            currentSubSetting = listview.model.get(selectedIndex).name;
            if (selectedIndex === 0) {
                listview.model = daESCModel;
            } else {
                listview.model = daTrafficModel;}
        } else if (listview.model === lightningModel) {
            currentSubSetting = listview.model.get(selectedIndex).name;
            if (selectedIndex === 0) {
                listview.model = lightningAutoModel;
            } else {
                listview.model = lightningHdlampModel;
            }
        } else if (listview.model === chimesModel) {
            currentSubSetting = listview.model.get(selectedIndex).name;
            if (selectedIndex === 0) {
                listview.model = chimesParkModel;
            } else if (selectedIndex === 1) {
                listview.model = chimesInfoModel;
            } else {
                listview.model = chimesWarningModel;
            }
        } else if (listview.model === convenienceModel) {
            currentSubSetting = listview.model.get(selectedIndex).name;
            if (selectedIndex === 0) {
                listview.model = convenienceAuxModel;
            } else {
                listview.model = convenienceParkHeaterModel
            }
        }
    }
    function handleAction(selectedIndex) {
        if (selectedIndex === listview.count -1) {
            subMenuLevel--;
        } else {
            var selectedOption = listview.model.get(selectedIndex).name;
            if (listview.model === displayColorModel) {
                redTheme = selectedOption === qsTr("Red") ? true : false
            } else if (listview.model === displayUnitModel) {
                useMetric = selectedOption === qsTr("Kph") ? true : false
            } else if (listview.model === daESCModel) {
                esc = selectedOption;
            } else if (listview.model === daTrafficModel) {
                trafficSigns = selectedOption;
            } else if (listview.model === lightningAutoModel) {
                autoHighBeam = selectedOption;
            } else if (listview.model === lightningHdlampModel) {
                hdLampDelay = selectedOption;
            } else if (listview.model === chimesParkModel) {
                chimesPark = selectedOption;
            } else if (listview.model === chimesInfoModel) {
                chimesInfo = selectedOption;
            } else if (listview.model === chimesWarningModel) {
                chimesWarning = selectedOption;
            } else if (listview.model === convenienceAuxModel) {
                auxHeater = selectedOption;
            } else if (listview.model === convenienceParkHeaterModel) {
                parkHeater = selectedOption;
            }
        }
    }
    function getCheckVisibility(itemName) {
        var result = false;
        if (listview.model === displayColorModel) {
            if (itemName === qsTr("Red") && redTheme) {
                result =  true;
            } else if (itemName === qsTr("Blue") && !redTheme) {
                result = true;
            }
        } else if (listview.model === displayUnitModel) {
            if (itemName === qsTr("Kph") && useMetric) {
                result = true;
            } else if (itemName === qsTr("Mph") && !useMetric) {
                result = true;
            }
        } else if (listview.model === daESCModel) {
            return itemName === esc ? true : false;
        } else if (listview.model === daTrafficModel) {
            return itemName === trafficSigns ? true : false;
        } else if (listview.model === lightningAutoModel) {
            return itemName === autoHighBeam ? true : false;
        } else if (listview.model === lightningHdlampModel) {
            return itemName === hdLampDelay ? true : false;
        } else if (listview.model === chimesParkModel) {
            return itemName === chimesPark ? true : false;
        } else if (listview.model === chimesInfoModel) {
            return itemName === chimesInfo ? true : false;
        } else if (listview.model === chimesWarningModel) {
            return itemName === chimesWarning ? true : false;
        } else if (listview.model === convenienceAuxModel) {
            return itemName === auxHeater ? true : false;
        } else if (listview.model === convenienceParkHeaterModel) {
            return itemName === parkHeater ? true : false;
        }
        return result;
    }

    Component {
      id: settingsListDelegate
      Item {
          width: listview.width
          height: 100
          Text {
              id: itemText
              text: name
              visible: name !== qsTr("Back")
              color: "#ffffff"
              opacity: itemOpacity
              font.pixelSize: 50
              anchors.verticalCenter: parent.verticalCenter
              anchors.horizontalCenter: parent.horizontalCenter
          }
          Image {
              id: backIcon
              source: menuBackSrc
              visible: name === qsTr("Back")
              fillMode: Image.PreserveAspectFit
              anchors.verticalCenter: parent.verticalCenter
              anchors.horizontalCenter: parent.horizontalCenter
          }
          Text {
              id: checkMark
              text: "\u2713"
              visible: getCheckVisibility(itemText.text)
              color: "#ffffff"
              opacity: itemOpacity
              font.pixelSize: 50
              anchors.verticalCenter: parent.verticalCenter
              anchors.right: itemText.left
              anchors.rightMargin: 20
          }
          MouseArea {
              anchors.fill: parent
              onClicked:  {
                  if (selectedMenuIndex !== index) {
                    selectedMenuIndex = index;
                    highlightTimer.start();
                  } else {
                    selectedMenuIndex = index;
                    handleMenu();
                  }
              }
          }
      }
    }

    Timer {
        id: highlightTimer
        interval: highlightSpeed === 200 ? 500 : 1000
        onTriggered: { handleMenu(); }
    }

    SettingsMainModel {
        id: mainModel
    }

    SettingsDisplayModel {
        id: displayModel
    }
    DisplayColorModel {
        id: displayColorModel
    }
    DisplayUnitsModel {
        id: displayUnitModel
    }

    SettingsDriverAssistModel {
        id: daModel
    }
    DriverAssistESCModel {
        id: daESCModel
    }
    DriverAssistTrafficSignsModel {
        id: daTrafficModel
    }

    SettingsLightningModel {
        id: lightningModel
    }
    LightningAutoHighbeamModel {
        id: lightningAutoModel
    }
    LightningHdlampModel {
        id: lightningHdlampModel
    }

    SettingsChimesModel {
        id: chimesModel
    }
    ChimesParkSlotModel {
        id: chimesParkModel
    }
    ChimesInformationModel {
        id: chimesInfoModel
    }
    ChimesWarningModel {
        id: chimesWarningModel
    }
    OnOffModel {
        id: onOffModel
    }

    SettingsConvenienceModel {
        id: convenienceModel
    }
    ConvenienceAuxModel {
        id: convenienceAuxModel
    }
    ConvenienceParkHeaterModel {
        id: convenienceParkHeaterModel
    }
}
