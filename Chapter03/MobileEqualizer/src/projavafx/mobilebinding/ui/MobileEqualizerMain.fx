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
 * MobileEqualizerMain.fx - Demonstrate keyboard and mouse input event
 * handling binding with UI classes in the JavaFX Common profile.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.mobilebinding.ui;

import javafx.stage.Stage;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.*;

var levels: Number[] = [30, 40, 50, 45, 35];
var selectedBarIndex: Integer = 0;
def MAX_LEVEL: Number = 230;
def MIN_LEVEL:Number = 10;
var groupRef: Group;

Stage {
  title: "Binding Example"
  scene: Scene {
    fill: Color.BLACK
    width: 240
    height: 320
    content: [
      Text {
        layoutX: 25
        layoutY: 20
        textOrigin: TextOrigin.TOP
        font: Font {
          name: "Sans serif"
          size: 18
        }
        content: "Binding / KeyEvent 2"
        fill: Color.WHITE
      },
      groupRef = Group {
        focusTraversable: true
        content: bind for (level in levels)
          Rectangle {
            x: 0
            y: 60 + (indexof level * 30)
            width: level
            height: 20
            fill: LinearGradient {
              startX: 0.0, startY: 0.0, endX: 0.0, endY: 1.0
              stops: [ Stop { offset: 0.0 color: Color.LIGHTBLUE },
                   Stop { offset: 1.0 color: Color.DARKBLUE } ]
            }
            opacity: if (indexof level == selectedBarIndex) 1 else 0.7
            onMousePressed: function(me:MouseEvent):Void {
              selectedBarIndex = indexof level;
            }
            onMouseDragged: function(me:MouseEvent):Void {
              if (me.x >= MIN_LEVEL and me.x <= MAX_LEVEL) {
                levels[indexof level] = me.x;
              }
            }
          }
        onKeyPressed: function(ke:KeyEvent):Void {
          if (ke.code == KeyCode.VK_RIGHT and levels[selectedBarIndex] <=
              MAX_LEVEL - 10) {
            levels[selectedBarIndex] += 10;
          }
          else if (ke.code == KeyCode.VK_LEFT and levels[selectedBarIndex] >
                    MIN_LEVEL + 10) {
            levels[selectedBarIndex] -= 10;
          }
          else if (ke.code == KeyCode.VK_DOWN) {
            selectedBarIndex = (selectedBarIndex + 1) mod sizeof levels;
          }
          else if (ke.code == KeyCode.VK_UP) {
            selectedBarIndex = (sizeof levels + selectedBarIndex - 1) mod
                                sizeof levels;
          }
        }
      },
      Text {
        layoutX: 25
        layoutY: 220
        textOrigin: TextOrigin.TOP
        font: Font {
          name: "Sans serif"
          size: 18
        }
        content: bind
            "Bar:{selectedBarIndex + 1}, Level: {levels[selectedBarIndex]}"
        fill: Color.WHITE
      }
    ]
  }
}
groupRef.requestFocus();