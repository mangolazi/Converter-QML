// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "dbcore.js" as DBcore

// CHOOSE CONVERSION TYPES AND UNITS

Page {
    id: formulaPage
    tools: mainToolbar
    //property variant conversion // conversion function
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
    }


    // CATEGORY LIST
    ListView {
        id: categoryList
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80
        width: parent.width
        model: categoryListModel
        delegate: categoryDelegate
        //highlightFollowsCurrentItem: false
        //highlight: highlightItem
        orientation: ListView.Horizontal
        currentIndex: -1
        focus: true
        clip: true
        snapMode: ListView.SnapToItem
    }

    ListModel {
        id: categoryListModel
    }

    Component {
      id: categoryDelegate
      ListItem {
          //property variant myData: model
          width: (categoryTxt.width > 120) ? categoryTxt.width + 10 : 120
          height: (categoryTxt.height > 80) ? categoryTxt.height + 10 : 80

          Text {
              //anchors.fill: parent
              id: categoryTxt
              anchors.horizontalCenter: parent.horizontalCenter
              anchors.verticalCenter: parent.verticalCenter
              text: unittype
              font.pixelSize: 28
              font.bold: (text == selectedCategory) ? true : false
              color: (text == selectedCategory) ? "red" : "lightgray"
              verticalAlignment: Text.AlignVCenter
              horizontalAlignment: Text.AlignHCenter
              wrapMode: Text.Wrap
          }

          onClicked: {
              selectedCategory = model.unittype
              resetInput()
              inputListModel = 0
              DBcore.readInputUnitList(inputListModel, model.unittype)
              inputList.model = inputListModel
          }
      }
    } // END CATEGORY LIST


    // INPUT HEADER
    Text {
        id: inputHeader
        anchors.top: categoryList.bottom
        anchors.left: parent.left
        anchors.topMargin: 5
        //anchors.right: parent.horizontalCenter
        width: parent.width/2
        text: "From"
        font.pixelSize: 26
        font.bold: true
        color: "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        states: [
            State {
                name: "LANDSCAPE";
                //AnchorChanges { target: inputHeader; anchors.right: inputList.left }
                PropertyChanges { target: inputHeader; width: 60}
            },
            State {
                name: "PORTRAIT";
                //AnchorChanges { target: inputHeader; anchors.right: parent.horizontalCenter }
                PropertyChanges { target: inputHeader; width: parent.width/2}
            }
        ]
    }


    // INPUT LIST
    ListView {
        id: inputList
        anchors.top: inputHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        //anchors.rightMargin: 5
        anchors.bottom: parent.bottom        
        model: inputListModel
        delegate: inputDelegate
        currentIndex: -1
        clip: true
        snapMode: ListView.StopAtBounds

        states: [
            State {
                name: "LANDSCAPE";
                AnchorChanges { target: inputList; anchors.left: inputHeader.right }
                AnchorChanges { target: inputList; anchors.top: categoryList.bottom }
                //PropertyChanges { target: inputList; width: parent.width/4 }
            },
            State {
                name: "PORTRAIT";
                AnchorChanges { target: inputList; anchors.left: parent.left }
                AnchorChanges { target: inputList; anchors.top: inputHeader.bottom }
                //PropertyChanges { target: inputList; width: parent.width/2 }
            }
        ]
    }

    ListModel {
        id: inputListModel
    }

    Component {
        id: inputDelegate

        ListItem {
            //property variant myData: model            
            height: (inputDescTxt.height > 60) ? inputDescTxt.height + 10 : 60

            Text {
                id: inputDescTxt
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                text: inputdesc
                font.pixelSize: 24
                font.bold: (text == selectedInput) ? true : false
                color: (text == selectedInput) ? "red" : "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
            }

            onClicked: {
                selectedInput = model.inputdesc
                resetInput()
                DBcore.readOutputUnitList(outputListModel, model.inputdesc)
                console.log("Input " + model.inputdesc)
                outputList.model = outputListModel
            }
        }
    } // END INPUT LIST


    // OUTPUT HEADER
    Text {
        id: outputHeader
        anchors.top: categoryList.bottom
        anchors.left: parent.horizontalCenter
        anchors.topMargin: 5
        //anchors.right: parent.right
        width: parent.width/2
        text: "To"
        font.pixelSize: 26
        font.bold: true
        color: "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        states: [
            State {
                name: "LANDSCAPE";
                //AnchorChanges { target: outputHeader; anchors.left: inputList.right }
                //AnchorChanges { target: outputHeader; anchors.right: undefined } //outputList.left }
                PropertyChanges { target: outputHeader; width: 60}
            },
            State {
                name: "PORTRAIT";
                //AnchorChanges { target: outputHeader; anchors.left: parent.horizontalCenter }
                //AnchorChanges { target: outputHeader; anchors.right: parent.right }
                PropertyChanges { target: outputHeader; width: parent.width/2}
            }
        ]
    }


    // OUTPUT LIST
    ListView {
        id: outputList
        anchors.top: outputHeader.bottom
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        //height: parent.height - categoryList.height        
        model: outputListModel
        delegate: outputDelegate
        currentIndex: -1
        clip: true
        snapMode: ListView.StopAtBounds

        states: [
            State {
                name: "LANDSCAPE";
                AnchorChanges { target: outputList; anchors.left: outputHeader.right }
                AnchorChanges { target: outputList; anchors.top: categoryList.bottom }
                //PropertyChanges { target: outputList; width: parent.width/2 }
            },
            State {
                name: "PORTRAIT";
                AnchorChanges { target: outputList; anchors.left: parent.horizontalCenter }
                AnchorChanges { target: outputList; anchors.top: outputHeader.bottom }
                //PropertyChanges { target: outputList; width: parent.width/4 }
            }
        ]
    }

    ListModel {
        id: outputListModel
    }

    Component {
        id: outputDelegate

        ListItem {
            //property variant myData: model
            //width: 160
            height: (outputDescTxt.height > 60) ? outputDescTxt.height + 10 : 60

            Text {
                id: outputDescTxt
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                text: outputdesc
                font.pixelSize: 24
                font.bold: (text == selectedOutput) ? true : false
                color: (text == selectedOutput) ? "red" : "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
            }

            onClicked: {
                selectedOutput = model.outputdesc
                console.log("Output " + model.outputdesc)
                DBcore.conversionfx = DBcore.readConversionFx(selectedInput, selectedOutput)
                console.log("Conversion fx is " + DBcore.conversionfx.conversion)
                close()
            }
        }
      } // END OUTPUT LIST


     // LOAD DATABASE ON START
     Component.onCompleted: {
         DBcore.openDB()
         categoryListModel = 0
         DBcore.readCategoryList(categoryListModel);
     }

     // RESET ALL INPUTS
     function resetInput() {
         outputListModel = 0
         outputList.model = 0
         //selectedOutput = ""
         //outputTxt.text = ""
     }

     // CLOSE PAGE AND REFRESH ALL PREVIOUS FIELDS
     function close() {
         if (DBcore.conversionfx !== "") {
             if (inputTxt.acceptableInput == true) {
                outputTxt.text = DBcore.calcResult(inputTxt.text);
             }
             inputLabel.text = selectedInput;
             outputLabel.text = selectedOutput;
         }
         else {
             outputTxt.text = "";
             inputLabel.text = "";
             outputLabel.text = "";
         }
         pageStack.pop()
     }


     // PAGE STATE MACHINE FOR PORTRAIT AND LANDSCAPE ORIENTATION SWITCH     
     states: [
         State {
             name: "landscape"; when: (inPortrait == false)
             PropertyChanges { target: inputHeader; state: "LANDSCAPE" }
             PropertyChanges { target: inputList; state: "LANDSCAPE" }
             PropertyChanges { target: outputHeader; state: "LANDSCAPE" }
             PropertyChanges { target: outputList; state: "LANDSCAPE" }
             },
         State {
             name: "portrait"; when: (inPortrait == true)
             PropertyChanges { target: inputHeader; state: "PORTRAIT" }
             PropertyChanges { target: inputList; state: "PORTRAIT" }
             PropertyChanges { target: outputHeader; state: "PORTRAIT" }
             PropertyChanges { target: outputList; state: "PORTRAIT" }
             }
     ]


} // END PAGE
