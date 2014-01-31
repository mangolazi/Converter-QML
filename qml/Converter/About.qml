/* Copyright © mangolazi 2012.
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

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: about
    tools: mainToolbar
    property string version : "0.3.0"

    // Default toolbar
    ToolBarLayout {
        id: mainToolbar
        ToolButton {
            id: toolbarbtnBack
            flat: true
            iconSource: "toolbar-back"
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked: {
                    window.pageStack.pop()
            }
        }
   }


    Text {
        id: versionTxt
        anchors.top: parent.top
        anchors.topMargin: 20
        width: parent.width
        text: "About Converter Qt " + version
        font.pointSize: 10
        font.bold: true
        color: "lightgray"
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignLeft
    }

    Text {
        anchors.top: versionTxt.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        width: parent.width
        text: "Converter is a simple unit converter app that uses OfflineStorage API and Sqlite databases to store custom conversion functions.\n\nSelect the category of units, select an input and output unit, and enter the input value. The converted output is then shown. <COPY> copies output to clipboard, <PASTE> pastes number in clipboard to input.\n\nLicensed under GPLv3. Source at https://github.com/mangolazi/Converter"
        font.pointSize: 8
        font.bold: false
        color: "white"
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignLeft
    }


} // end page
