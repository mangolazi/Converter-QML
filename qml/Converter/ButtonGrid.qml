// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

// BUTTON GRID
Grid {
    columns: 4
    rows: 4
    spacing: 10

    Button { text: "7" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("7") }
    }
    Button { text: "8" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("8") }
    }
    Button { text: "9" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("9") }
    }
    Button { text: "C" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: {
            inputTxt.text = inputTxt.text.toString().slice(0, -1)
            if (inputTxt.text.length == 0) {
                inputTxt.text = ""
            }
        }
    }
    Button { text: "4" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("4") }
    }
    Button { text: "5" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("5") }
    }
    Button { text: "6" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("6") }
    }
    Button { text: "AC" ; font.pixelSize: 32 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: {
            inputTxt.text = ""
            outputTxt.text = ""
        }
    }
    Button { text: "1" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("1") }
    }
    Button { text: "2" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("2") }
    }
    Button { text: "3" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("3") }
    }
    Button { text: "Copy" ; font.pixelSize: 26 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { outputTxt.selectAll(); outputTxt.copy() }
    }
    Button { text: "." ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum(".") }
    }
    Button { text: "0" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("0") }
    }
    Button { text: "+-" ; font.pixelSize: 36 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { enterNum("+-") }
    }
    Button { text: "Paste" ; font.pixelSize: 24 ;
        height: parent.height/4 - parent.spacing; width: parent.width/4 - parent.spacing
        onClicked: { inputTxt.text = ""; inputTxt.paste() }
    }

    // Add number or sign to input
    function enterNum(keys) {       
        var oldText = inputTxt.text;
        var pattneg = /-.*/

        if (keys == "+-") {
            if (pattneg.test(oldText)) {
                inputTxt.text = oldText.replace("-","");
            }
            else {
                inputTxt.text = "-" + oldText
            }
        }
        else {
            inputTxt.text += keys;
            if (inputTxt.acceptableInput == false) { inputTxt.text = oldText }
        }

    }
 }
