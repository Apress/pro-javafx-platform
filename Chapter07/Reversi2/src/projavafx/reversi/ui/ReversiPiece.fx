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
 * ReversiPiece.fx - Part of the Reversi application example that illustrates
 * dynamic layout of Nodes in a JavaFX user interface utilitizing bind,
 * boxes, and Containers.
 *
 * Developed 2009 by Stephen Chin
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.reversi.ui;

import javafx.geometry.BoundingBox;
import javafx.scene.CustomNode;
import javafx.scene.effect.Reflection;
import javafx.scene.layout.Resizable;
import javafx.scene.paint.Color;
import javafx.scene.paint.RadialGradient;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Ellipse;
import javafx.scene.transform.Transform;
import projavafx.reversi.model.Cell;
import projavafx.reversi.model.Owner;

/**
 * @author Stephen Chin
 */
public class ReversiPiece extends CustomNode, Resizable, Cell {

  override function getPrefWidth(height) {30.0}
  override function getPrefHeight(width) {30.0}

  override var layoutBounds = bind lazy BoundingBox {
      minX: 0
      minY: 0
      width: width
      height: height
  }

  public var owner:Owner;

  public var scale = 1.0;

  override var cache = true;

  override var effect = Reflection {
    fraction: 1.0
    topOffset: bind -height * 1/2
  }

  override function create() {
    Ellipse {
      transforms: bind Transform.scale(scale, scale)
      layoutX: bind width / 2
      layoutY: bind height / 2
      radiusX: bind width / 2
      radiusY: bind height / 2
      fill: bind if (owner == Owner.WHITE) {
        RadialGradient {
          stops: [
            Stop {offset: 0.4, color: Color.WHITE}
            Stop {offset: 0.9, color: Color.GRAY}
            Stop {offset: 1.0, color: Color.DARKGRAY}
          ]
        }
      } else {
        RadialGradient {
          stops: [
            Stop {offset: 0.0, color: Color.WHITE}
            Stop {offset: 0.6, color: Color.BLACK}
          ]
        }
      }
      stroke: Color.color(0.3, 0.3, 0.3)
    }
  }
}
