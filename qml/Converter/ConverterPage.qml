/* Copyright Ac mangolazi 2012.
This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// Converter main page, does all calculations here
import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1     // Extras
import "dbcore.js" as DBcore

Page {
    id: converterPage
    tools: mainToolbar
    property variant conversion // conversion function
    property string selectedCategory
    property string selectedInput
    property string selectedOutput

    // Default toolbar
    ToolBarLayout {
        id: mainToolbar

        ToolButton {
            id: toolbarbtnBack
            flat: true
            iconSource: "toolbar-back"
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked:
            {
                pageStack.depth <= 1 ? Qt.quit() : pageStack.pop()
            }
        }

        ToolButton {
            id: toolbarbtnMenu
            flat: true
            iconSource: "toolbar-menu"
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: mainMenu.open()
        }
    }


    // main menu
    Menu {
         id: mainMenu
         content: MenuLayout {
             MenuItem {
                 text: "About"
                 onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
             }
         }
     }


    // INPUT BOX
    TextInput {
        id: inputTxt
        anchors.top: parent.top
        anchors.topMargin: 5
        width: parent.width
        font.pointSize: 16
        font.bold: true
        color: "white"
        horizontalAlignment: Text.AlignRight
        inputMethodHints: Qt.ImhFormattedNumbersOnly        
        maximumLength: 12
        validator: DoubleValidator { decimals: 2 ;
            notation: DoubleValidator.StandardNotation }
        onTextChanged: {
            var pattzero = /^-*0\d{1}/
            var pattdecimal = /^-*[.]+/
            if (pattzero.test(text)) {
                text = text.replace(0, "")
            }
            else if (pattdecimal.test(text)) {
                text = text.replace(".", "0.")
            }
            if ( DBcore.conversionfx !== "" && inputTxt.acceptableInput == true ) {
                outputTxt.text = DBcore.calcResult(inputTxt.text)
            }
        }

        states: [
            State {
                name: "LANDSCAPE";
                PropertyChanges { target: inputTxt; width: parent.width/2}
            },
            State {
                name: "PORTRAIT";
                PropertyChanges { target: inputTxt; width: parent.width}
            }
        ]
    }

    // INPUT LABEL
    Text {
        id: inputLabel
        anchors.top: inputTxt.bottom
        width: parent.width
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        text: selectedInput
        font.pointSize: 8
        color: "lightgray"
        states: [
            State {
                name: "LANDSCAPE";
                PropertyChanges { target: inputLabel; width: parent.width/2}
            },
            State {
                name: "PORTRAIT";
                PropertyChanges { target: inputLabel; width: parent.width}
            }
        ]
    }


    // OUTPUT VALUE
    TextInput {
        id: outputTxt
        anchors.top: inputLabel.bottom
        anchors.topMargin: 10        
        width: parent.width
        font.pointSize: 16
        font.bold: true
        color: "white"
        horizontalAlignment: Text.AlignRight
        readOnly: true        
        maximumLength: 15

        states: [
            State {
                name: "LANDSCAPE";
                PropertyChanges { target: outputTxt; width: parent.width/2}
            },
            State {
                name: "PORTRAIT";
                PropertyChanges { target: outputTxt; width: parent.width}
            }
        ]
    }


    // OUTPUT LABEL
    Text {
        id: outputLabel
        anchors.top: outputTxt.bottom
        width: parent.width
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        text: selectedOutput
        font.pointSize: 8
        color: "lightgray"
        states: [
            State {
                name: "LANDSCAPE";
                PropertyChanges { target: outputLabel; width: parent.width/2}
            },
            State {
                name: "PORTRAIT";
                PropertyChanges { target: outputLabel; width: parent.width}
            }
        ]
    }


    // FUNCTION CATEGORY SELECTION
    SelectionListItem {
             id: categoryList
             anchors.top: outputLabel.bottom
             anchors.topMargin: 10
             width: parent.width
             title: "Conversion Functions"
             onClicked: {
                 selectCategory.open()
             }
             SelectionDialog {
                 id: selectCategory
                 model: categoryModel
                 titleText: "Select a conversion category"
                 delegate: selectCategoryDelegate
             }
             states: [
                 State {
                     name: "LANDSCAPE";
                     PropertyChanges { target: categoryList; width: parent.width/2}
                     PropertyChanges { target: categoryList; anchors.topMargin: 30}
                 },
                 State {
                     name: "PORTRAIT";
                     PropertyChanges { target: categoryList; width: parent.width}
                     PropertyChanges { target: categoryList; anchors.topMargin: 10}
                 }
             ]

    }

    Component {
            id: selectCategoryDelegate
            MenuItem {
                text: unittype
                onClicked: {
                    selectedCategory = model.unittype
                    root.accept()
                    DBcore.readInputUnitList(inputModel, model.unittype)
                    selectInput.open()
                }
            }
        }

    // INPUT SELECTION
    SelectionDialog {
        id: selectInput
        model: inputModel
        titleText: "Select input"
        delegate: selectInputDelegate
    }

    Component {
            id: selectInputDelegate
            MenuItem {
                text: inputdesc
                onClicked: {
                    selectedInput = model.inputdesc
                    DBcore.readOutputUnitList(outputModel, model.inputdesc)
                    selectOutput.model = outputModel
                    close()
                    selectOutput.open()
                }
            }
        }

    // OUTPUT SELECTION
    SelectionDialog {
        id: selectOutput
        model: outputModel
        titleText: "Select output"
        delegate: selectOutputDelegate
    }

    Component {
            id: selectOutputDelegate
            MenuItem {
                text: outputdesc
                onClicked: {
                    selectedOutput = model.outputdesc
                    DBcore.conversionfx = DBcore.readConversionFx(selectedInput, selectedOutput)
                    if (DBcore.conversionfx !== "") {
                        if (inputTxt.acceptableInput == true) {
                            outputTxt.text = DBcore.calcResult(inputTxt.text);
                        }
                    }
                    close()
                }
            }
        }

    // SELECTION DATA MODELS
    ListModel {
        id: categoryModel
    }

    ListModel {
        id: inputModel
    }

    ListModel {
        id: outputModel
    }

    // BUTTON GRID FOR DATA ENTRY
    ButtonGrid {
        id: buttonGrid
        anchors.top: categoryList.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        width: parent.width

        states: [
            State {
                name: "LANDSCAPE";
                AnchorChanges { target: buttonGrid; anchors.top: parent.top }
                PropertyChanges { target: buttonGrid; anchors.topMargin: 0 }
                AnchorChanges { target: buttonGrid; anchors.left: parent.horizontalCenter }
                PropertyChanges { target: buttonGrid; anchors.leftMargin: 10 }
                PropertyChanges { target: buttonGrid; width: parent.width/2}
            },
            State {
                name: "PORTRAIT";
                AnchorChanges { target: buttonGrid; anchors.top: categoryList.bottom }
                PropertyChanges { target: buttonGrid; anchors.topMargin: 10 }
                AnchorChanges { target: buttonGrid; anchors.left: parent.left }
                PropertyChanges { target: buttonGrid; anchors.leftMargin: 0 }
                PropertyChanges { target: buttonGrid; width: parent.width}
            }
        ]
    }


    // LOAD DATABASE ON START
    Component.onCompleted: {
        DBcore.openDB();
        DBcore.readCategoryList(categoryModel);
    }


    // PAGE STATE MACHINE FOR PORTRAIT AND LANDSCAPE ORIENTATION SWITCH
    states: [
        State {
            name: "landscape"; when: (inPortrait == false)
            PropertyChanges { target: inputTxt; state: "LANDSCAPE" }
            PropertyChanges { target: inputLabel; state: "LANDSCAPE" }
            PropertyChanges { target: outputTxt; state: "LANDSCAPE" }
            PropertyChanges { target: outputLabel; state: "LANDSCAPE" }
            PropertyChanges { target: categoryList; state: "LANDSCAPE" }
            PropertyChanges { target: buttonGrid; state: "LANDSCAPE" }
            },
        State {
            name: "portrait"; when: (inPortrait == true)
            PropertyChanges { target: inputTxt; state: "PORTRAIT" }
            PropertyChanges { target: inputLabel; state: "PORTRAIT" }
            PropertyChanges { target: outputTxt; state: "PORTRAIT" }
            PropertyChanges { target: outputLabel; state: "PORTRAIT" }
            PropertyChanges { target: categoryList; state: "PORTRAIT" }
            PropertyChanges { target: buttonGrid; state: "PORTRAIT" }
            }
    ]

} // END PAGE
