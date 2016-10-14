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
 * AlignTitleExample.fx - Chapter 7 example that illustrates
 * use of a Tile and Stack to layout nodes in a scene.
 *
 * Developed 2009 by Stephen Chin
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.reversi.examples;

import javafx.geometry.HPos;
import javafx.scene.*;
import javafx.scene.layout.LayoutInfo;
import javafx.scene.layout.Stack;
import javafx.scene.layout.Tile;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.text.*;

/**
 * @author Stephen Chin
 */
var scene:Scene;
scene = Scene {
  width: 400
  height: 100
  content: Tile {
    width: bind scene.width
    height: bind scene.height
    content: [
      Stack {
        content: [
          Rectangle {
            width: bind scene.width / 2
            height: bind scene.height
          }
          Text {
            layoutInfo: LayoutInfo {
              hpos: HPos.RIGHT
            }
            content: "JavaFX"
            font: Font.font(null, FontWeight.BOLD, 18)
            fill: Color.WHITE
          }
        ]
      }
      Text {
        layoutInfo: LayoutInfo {
          hpos: HPos.LEFT
        }
        content: "Reversi"
        font: Font.font(null, FontWeight.BOLD, 18)
      }
    ]
  }
}
