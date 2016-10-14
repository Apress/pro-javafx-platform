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
 * OnTheSceneMain.fx - A JavaFX Script example program that demonstrates
 * how to use the Scene class in JavaFX, and displays many of the variables'
 * values as the Scene is manipulated by the user.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.onthescene.ui;

import javafx.ext.swing.SwingComboBox;
import javafx.ext.swing.SwingComboBoxItem;
import javafx.geometry.HPos;
import javafx.scene.control.Hyperlink;
import javafx.scene.control.Slider;
import javafx.scene.control.RadioButton;
import javafx.scene.control.ToggleGroup;
import javafx.scene.Cursor;
import javafx.scene.Scene;
import javafx.scene.layout.Flow;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.scene.text.*;
import javafx.stage.Stage;

var sceneRef: Scene;
var cursorNames = [
  "DEFAULT",
  "CROSSHAIR",
  "WAIT",
  "TEXT",
  "HAND",
  "MOVE",
  "N_RESIZE",
  "NE_RESIZE",
  "E_RESIZE",
  "SE_RESIZE",
  "S_RESIZE",
  "SW_RESIZE",
  "W_RESIZE",
  "NW_RESIZE",
  "NONE"
];

var cursors = [
  Cursor.DEFAULT,
  Cursor.CROSSHAIR,
  Cursor.WAIT,
  Cursor.TEXT,
  Cursor.HAND,
  Cursor.MOVE,
  Cursor.N_RESIZE,
  Cursor.NE_RESIZE,
  Cursor.E_RESIZE,
  Cursor.SE_RESIZE,
  Cursor.S_RESIZE,
  Cursor.SW_RESIZE,
  Cursor.W_RESIZE,
  Cursor.NW_RESIZE,
  Cursor.NONE
];

var selectedCursorIndex: Integer;
var fillVals:Number = 255;

var onTheSceneSelected:Boolean = true on replace {
  if (onTheSceneSelected) {
    sceneRef.stylesheets = "{__DIR__}onTheScene.css";
  }
};

var changeOfSceneSelected:Boolean on replace {
  if (changeOfSceneSelected) {
    sceneRef.stylesheets = "{__DIR__}changeOfScene.css";
  }
};

Stage {
  title: "On the Scene"
  scene: sceneRef = Scene {
    width: 600
    height: 240
    cursor: bind cursors[selectedCursorIndex]
    fill: bind Color.rgb(fillVals, fillVals, fillVals)
    content: [
      Flow {
        var toggleGrp:ToggleGroup = ToggleGroup {}
        layoutX: 20
        layoutY: 40
        width: bind sceneRef.width - 20
        height: bind sceneRef.height - 40
        vertical: true
        vgap: 10
        hgap: 20
        nodeHPos: HPos.LEFT
        content: [
          HBox {
            spacing: 10
            content: [
              Slider {
                min: 0
                max: 255
                vertical: true
                value: bind fillVals with inverse
              },
              SwingComboBox {
                items: bind for (cursorName in cursorNames) {
                  SwingComboBoxItem {
                    text: cursorName
                  }
                }
                selectedIndex: bind selectedCursorIndex with inverse
                id: "combo"
              }
            ]
          },
          Text {
            font: Font.font("Sans Serif", 14)
            content: bind "Scene x: {sceneRef.x}"
          },
          Text {
            font: Font.font("Sans Serif", 14)
            content: bind "Scene y: {sceneRef.y}"
          },
          Text {
            font: Font.font("Sans Serif", 14)
            content: bind "Scene width: {sceneRef.width}"
          },
          Text {
            font: Font.font("Sans Serif", 14)
            content: bind "Scene height: {sceneRef.height}"
            id: "sceneHeightText"
          },
          Hyperlink {
            text: "lookup()"
            id: "lookup"
            action: function():Void {
              var textRef = sceneRef.lookup("sceneHeightText") as Text;
              println(textRef.content);
            }
          },
          RadioButton {
            text: "onTheScene.css"
            toggleGroup: toggleGrp
            selected: bind onTheSceneSelected with inverse
            id: "radio1"
            styleClass: "radios"
          },
          RadioButton {
            text: "changeOfScene.css"
            toggleGroup: toggleGrp
            selected: bind changeOfSceneSelected with inverse
            id: "radio2"
            styleClass: "radios"
          },
          Text {
            id: "stageX"
            font: Font.font("Sans Serif", 14)
            content: bind "Stage x: {sceneRef.stage.x}"
          },
          Text {
            id: "stageY"
            font: Font.font("Sans Serif", 14)
            content: bind "Stage y: {sceneRef.stage.y}"
          },
          Text {
            font: Font.font("Sans Serif", 14)
            content: bind "Stage width: {sceneRef.stage.width}"
          },
          Text {
            font: Font.font("Sans Serif", 14)
            content: bind "Stage height: {sceneRef.stage.height}"
          }
        ]
      }
    ]
    stylesheets: "{__DIR__}onTheScene.css";
  }
}

// Demonstrate adding an element to the content sequence of the Scene
def textRef = Text {
  layoutX: 20
  layoutY: 10
  textOrigin: TextOrigin.TOP
  fill: Color.BLUE
  font: Font.font("Sans Serif", FontWeight.BOLD, 14)
  content: bind "sceneRef.fill: {sceneRef.fill}"
};
insert textRef into sceneRef.content;
