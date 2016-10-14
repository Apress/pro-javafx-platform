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
 * MobileBindingMain.fx - Demonstrate keyboard and mouse input event
 * handling binding with UI classes in the JavaFX Mobile profile.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.mobilebinding.ui;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.*;

var level: Number = 30;
def MAX_LEVEL: Number = 230;
def MIN_LEVEL: Number = 10;
var rectRef: Rectangle;

Stage {
    title: "Binding Example"
    scene: Scene {
        fill: Color.BLACK
        width: 240
        height: 320
        content: [
            Text {
                translateX: 20
                translateY: 20
                textOrigin: TextOrigin.TOP
                font: Font {
                    name: "Sans serif"
                    size: 18
                }
                content: "Binding / KeyEvent 1"
                fill: Color.WHITE
            },
            rectRef = Rectangle {
                x: 0
                y: 60
                width: bind level
                height: 20
                fill: LinearGradient {
                    startX: 0.0,
                    startY: 0.0,
                    endX: 0.0,
                    endY: 1.0
                    stops: [ 
                        Stop {
                            offset: 0.0
                            color: Color.LIGHTBLUE
                        },
                        Stop {
                            offset: 1.0
                            color: Color.DARKBLUE
                        } ]
                }
                onMouseDragged: function(me:MouseEvent):Void {
                    if (me.x >= MIN_LEVEL and me.x <= MAX_LEVEL) {
                        level = me.x;
                    }
                }
                onKeyPressed: function(ke:KeyEvent):Void {
                    if (ke.code == KeyCode.VK_RIGHT and level <= MAX_LEVEL - 10) {
                        level += 10;
                    }
                    else if (ke.code == KeyCode.VK_LEFT and level >= MIN_LEVEL + 10) {
                        level -= 10;
                    }
                }
            },
            Text {
                translateX: 20
                translateY: 100
                textOrigin: TextOrigin.TOP
                font: Font {
                    name: "Sans serif"
                    size: 18
                }
                content: bind "Level: {level}"
                fill: Color.WHITE
            }
        ]
    }
}
rectRef.requestFocus();