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
 * PlayerScoreExample.fx - Chapter 5 example that illustrates
 * use of layouts to align nodes to each other.
 *
 * Developed 2009 by Stephen Chin
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.reversi.examples;

import projavafx.reversi.model.*;
import javafx.scene.*;
import javafx.scene.effect.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.text.*;
import javafx.stage.*;
import javafx.scene.layout.Flow;
import javafx.geometry.VPos;
import javafx.scene.layout.Stack;
import javafx.geometry.HPos;
import javafx.scene.effect.DropShadow;
import javafx.scene.paint.Color;
import javafx.scene.shape.Ellipse;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import projavafx.reversi.model.Owner;
import javafx.scene.layout.VBox;
import javafx.scene.layout.Tile;

/**
 * @author Stephen Chin
 */
def model = ReversiModel {}

Stage {
  title: "Player Score Example"
  var scene:Scene;
  scene: scene = Scene {
    width: 600
    height: 120
    content: Tile {
      width: bind scene.width
      height: bind scene.height
      tileWidth: bind scene.width / 2
      tileHeight: bind scene.height
      content: [
        createScore(Owner.BLACK),
        createScore(Owner.WHITE)
      ]
    }
  }
}

function createScore(owner:Owner) {
  var stack:Stack;
  stack = Stack {
    content: [
      Rectangle {
        def shadow = InnerShadow {color: bind Color.DODGERBLUE, choke: 0.5};
        effect: bind if (model.turn == owner) shadow else null
        width: bind stack.width
        height: bind stack.height
        fill: model.getColor(owner.opposite())
      }
      Flow {
        hpos: HPos.CENTER
        vpos: VPos.CENTER
        nodeVPos: VPos.BASELINE
        hgap: 20
        vgap: 10
        content: [
          Text {
            content: bind "{model.getScore(owner)}"
            font: Font.font(null, FontWeight.BOLD, 100)
            fill: model.getColor(owner)
          }
          VBox {
            nodeHPos: HPos.CENTER
            spacing: 10
            content: [
              Ellipse {
                def shadow = DropShadow {color: bind Color.DODGERBLUE, spread: 0.2};
                effect: bind if (model.turn == owner) shadow else null
                radiusX: 32
                radiusY: 20
                fill: model.getColor(owner)
              }
              Text {
                content: bind "{model.getTurnsRemaining(owner)} turns remaining"
                font: Font.font(null, FontWeight.BOLD, 12)
                fill: model.getColor(owner)
              }
            ]
          }
        ]
      }
    ]
  }
}
