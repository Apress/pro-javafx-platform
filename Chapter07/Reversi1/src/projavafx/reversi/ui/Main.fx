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
 * ReversiBoard.fx - Part of the Reversi application example that illustrates
 * dynamic layout of Nodes in a JavaFX user interface utilitizing bind,
 * layouts, and Containers.
 *
 * Developed 2009 by Stephen Chin
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.reversi.ui;

import javafx.geometry.HPos;
import javafx.geometry.VPos;
import javafx.scene.Scene;
import javafx.scene.effect.DropShadow;
import javafx.scene.effect.InnerShadow;
import javafx.scene.layout.Container;
import javafx.scene.layout.Flow;
import javafx.scene.layout.LayoutInfo;
import javafx.scene.layout.Panel;
import javafx.scene.layout.Stack;
import javafx.scene.layout.Tile;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.paint.RadialGradient;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Ellipse;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import projavafx.reversi.layout.GridLayout;
import projavafx.reversi.model.Owner;
import projavafx.reversi.model.ReversiModel;

/**
 * @author Stephen Chin
 */
def model = ReversiModel {}

Stage {
  title: "JavaFX Reversi"
  var scene:Scene;
  scene: scene = Scene {
    width: 480
    height: 480
    def titleHeight = 30;
    def scoreHeight = 120;
    def title = createTitle();
    def grid = createReversiGrid();
    def score = createScoreBoxes();
    content: bind [
      Panel {
        width: bind scene.width
        height: bind scene.height
        content: [
          title,
          score,
          grid
        ]
        onLayout: function() {
          def boardHeight = scene.height - titleHeight - scoreHeight;
          Container.layoutNode(title, 0, 0, scene.width, titleHeight);
          Container.layoutNode(grid, 0, titleHeight, scene.width, boardHeight);
          Container.layoutNode(score, 0, scene.height - scoreHeight,
                               scene.width, scoreHeight);
        }
      }
    ]
  }
}

function createTitle() {
  var tile:Tile;
  tile = Tile {
    content: [
      Stack {
        content: [
          Rectangle {
            width: bind tile.width / 2
            height: bind tile.height
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

function createBackground() {
  var stack:Stack;
  stack = Stack {
    content: Rectangle {
      width: bind stack.width
      height: bind stack.height
      fill: RadialGradient {
        stops: [
          Stop {
            color: Color.WHITE
          }
          Stop {
            offset: 1
            color: Color.color(0.2, 0.2, 0.2)
          }
        ]
      }
    }
  }
}

function createScoreBoxes() {
  var tile:Tile;
  tile = Tile {
    tileWidth: bind tile.width / 2
    tileHeight: bind tile.height
    content: [
      createScore(Owner.BLACK),
      createScore(Owner.WHITE)
    ]
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

function createReversiGrid() {
  Stack {
    content: [
      GridLayout {
        numColumns: ReversiModel.BOARD_SIZE
        numRows: ReversiModel.BOARD_SIZE
        content: for (x in [0..ReversiModel.BOARD_SIZE - 1],
                      y in [0..ReversiModel.BOARD_SIZE - 1]) {
          ReversiSquare {
            x: x
            y: y
          }
        }
      }
      GridLayout {
        numColumns: ReversiModel.BOARD_SIZE
        numRows: ReversiModel.BOARD_SIZE
        content: bind for (row in model.board,
                           cell in row.cells where cell != Owner.NONE) {
          ReversiPiece {
            scale: 0.7
            owner: cell
            x: indexof cell
            y: indexof row
          }
        }
      }
    ]
  }
}
