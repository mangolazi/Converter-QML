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

.pragma library

var db;
var conversionfx = "";

function openDB()
{
    db = openDatabaseSync("ConverterDB","1.0","Converter Database",10000);
    createTable();
}

function createTable()
{
    db.transaction(
                function(tx) {
                    tx.executeSql("CREATE TABLE IF NOT EXISTS units (id INTEGER PRIMARY KEY AUTOINCREMENT, unittype TEXT, input TEXT, inputdesc TEXT, output TEXT, outputdesc TEXT, conversion TEXT)");
                }
                )
}

function readCategoryList(model)
{
    model.clear()
    db.readTransaction(
                function(tx) {
                    var rs;
                    rs = tx.executeSql("SELECT DISTINCT unittype FROM units");
                    for (var i = 0; i < rs.rows.length; i++) {
                        model.append(rs.rows.item(i))
                    }
                }
                )
}

function readInputUnitList(model, unittype)
{
    model.clear()
    db.readTransaction(
                function(tx) {
                    var rs;
                    rs = tx.executeSql("SELECT DISTINCT inputdesc FROM units WHERE unittype = ? ORDER BY inputdesc ASC",[unittype]);
                    for (var i = 0; i < rs.rows.length; i++) {
                        model.append(rs.rows.item(i))
                    }
                }
                )
}


function readOutputUnitList(model, inputdesc)
{
    model.clear()
    db.readTransaction(
                function(tx) {
                    var rs;
                    rs = tx.executeSql("SELECT DISTINCT outputdesc FROM units WHERE inputdesc = ? ORDER BY outputdesc ASC",[inputdesc]);
                    for (var i = 0; i < rs.rows.length; i++) {
                        model.append(rs.rows.item(i))
                    }
                }
                )
}


function readConversionFx(inputdesc, outputdesc)
{
    var data = {}
    db.readTransaction(
                function(tx) {
                    var rs = tx.executeSql("SELECT conversion FROM units WHERE inputdesc = ? and outputdesc = ?",[inputdesc, outputdesc]);
                    if(rs.rows.length === 1) {
                        data = rs.rows.item(0)
                    }
                }
                )
    return data;
}

function defaultItem()
{
    return {title: "", category: "", note: "", modified: new Date()}
}

// CALCULATE RESULT
function calcResult(inputStr) {
        var i = parseFloat(inputStr)
        i = eval(conversionfx.conversion);
        if (i % 1 !== 0) { return new Number(i).toFixed(2); }
        else { return i; }
}
