/*
 * Copyright (c) 2009, Pro JavaFX Authors
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. Neither the name of JFXtras nor the names of its contributors may be used
 *    to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * StageCoachMain.fx - A JavaFX Script example program that demonstrates
 * how to use the Stage class in JavaFX, and displays many of the variable's
 * values as the Stage is manipulated by the user.  In addition, this
 * program demonstrates how to use the Alert class.  It also
 * demonstrates how to get arguments passed into the program, read system
 * properties, and use local storage.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.stagecoach.ui;

import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import javafx.util.Properties;

import javafx.io.Storage;
import javafx.io.Resource;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextBox;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.text.*;
import javafx.stage.Alert;
import javafx.stage.Screen;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

var args = FX.getArguments();
var stageStyle = StageStyle.DECORATED;
if (sizeof args >= 1) {
  if (args[0].toLowerCase() == "transparent") {
    stageStyle = StageStyle.TRANSPARENT;
  }
  else if (args[0].toLowerCase() == "undecorated"){
    stageStyle = StageStyle.UNDECORATED;
  }
}
var resizable:Boolean = true;
var fullScreen:Boolean = false;
var title:String = "Stage Coach";
var stageRef:Stage;
var entry:Storage;

function saveProperties():Void {
  println("Storage.list():{Storage.list()}");
  entry = Storage {
    source: "stagecoach.properties"
  };
  var resource:Resource = entry.resource;
  var properties:Properties = new Properties();
  properties.put("xPos", "{stageRef.x}");
  properties.put("yPos", "{stageRef.y}");
  try {
    var outputStream:OutputStream = resource.openOutputStream(true);
    properties.store(outputStream);
    outputStream.close();
    println("properties written");
  }
  catch (ioe:IOException) {
    println("IOException in saveProperties:{ioe}");
  }
}

function loadProperties():Void {
  println("Storage.list():{Storage.list()}");
  entry = Storage {
    source: "stagecoach.properties"
  };
  var resource:Resource = entry.resource;
  var properties:Properties = new Properties();
  try {
    var inputStream:InputStream = resource.openInputStream();
    properties.load(inputStream);
    inputStream.close();
    if (properties.get("xPos") != null) {
      stageRef.x = Double.parseDouble(properties.get("xPos"));
      stageRef.y = Double.parseDouble(properties.get("yPos"));
    }
    println("properties read");
  }
  catch (ioe:IOException) {
    println("IOException in loadProperties:{ioe}");
  }
  stageRef.visible = true;
}

function showSystemProperties():Void {
  Alert.inform("Some System Properties",
               "java.os.name: {FX.getProperty("javafx.os.name")}\n"
               "javafx.os.arch: {FX.getProperty("javafx.os.arch")}\n"
               "java.os.version: {FX.getProperty("javafx.os.version")}");
}

stageRef = Stage {
  visible: false
  title: bind title
  width: 330
  height: 550
  style: stageStyle
  resizable: bind resizable
  fullScreen: bind fullScreen
  onClose: function():Void {
    println("Stage is closing");
  }
  scene:Scene {
    fill: Color.TRANSPARENT
    content: [
      Rectangle {
        width: 300
        height: 500
        arcWidth: 50
        arcHeight: 50
        fill: Color.SKYBLUE
        onMouseDragged: function(me:MouseEvent):Void {
          stageRef.x += me.dragX;
          stageRef.y += me.dragY;
        }
        onMousePressed: function(me:MouseEvent):Void {
          if (me.popupTrigger) showSystemProperties();
        }
        onMouseReleased: function(me:MouseEvent):Void {
          if (me.popupTrigger) showSystemProperties();
        }
      },
      VBox {
        layoutX: 20
        layoutY: 20
        spacing: 10
        content: [
          Text {
            textOrigin: TextOrigin.TOP
            font: Font.font("Sans Serif", 14)
            content: bind "x: {stageRef.x}"
          },
          Text {
            textOrigin: TextOrigin.TOP
            font: Font.font("Sans Serif", 14)
            content: bind "y: {stageRef.y}"
          },
          Text {
            textOrigin: TextOrigin.TOP
            font: Font.font("Sans Serif", 14)
            content: bind "height: {stageRef.height}"
          },
          Text {
            textOrigin: TextOrigin.TOP
            font: Font.font("Sans Serif", 14)
            content: bind "width: {stageRef.width}"
          },
          Text {
            textOrigin: TextOrigin.TOP
            font: Font.font("Sans Serif", 14)
            content: bind "containsFocus: {stageRef.containsFocus}"
          },
          CheckBox {
            blocksMouse: true
            text: "resizable"
            selected: bind resizable with inverse
          },
          Text {
            textOrigin: TextOrigin.TOP
            font: Font.font("Sans Serif", 14)
            content: bind "resizable: {stageRef.resizable}"
          },
          CheckBox {
            blocksMouse: true
            text: "fullScreen"
            selected: bind fullScreen with inverse
          },
          Text {
            textOrigin: TextOrigin.TOP
            font: Font.font("Sans Serif", 14)
            content: bind "fullScreen: {stageRef.fullScreen}"
          },
          Label {
            font: Font.font("Sans Serif", 14)
            text: "title:"
          },
          TextBox {
            blocksMouse: true
            text: bind title with inverse
            columns: 15
          },
          Button {
            text: "toBack()"
            action: function():Void {
              stageRef.toBack();
            }
          },
          Button {
            text: "toFront()"
            action: function():Void {
              stageRef.toFront();
            }
          },
          Button {
            text: "close()"
            action: function():Void {
              saveProperties();
              stageRef.close();
            }
          },
          Button {
            text: "FX.exit()"
            action: function():Void {
              if (Alert.question("Are You Sure?",
                                 "Exit without saving screen position?")) {
                FX.exit();
              }
            }
          }
        ]
      }
    ]
  }
}
stageRef.x = (Screen.primary.visualBounds.width - stageRef.width) / 2;
stageRef.y = (Screen.primary.visualBounds.height - stageRef.height) / 4;
loadProperties();
