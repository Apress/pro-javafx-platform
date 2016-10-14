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
 * PerspectiveLayout.fx - Part of the Reversi application example that illustrates
 * dynamic layout of Nodes in a JavaFX user interface utilitizing bind,
 * boxes, and Containers.
 *
 * Developed 2009 by Stephen Chin
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.reversi.layout;

import projavafx.reversi.model.*;
import javafx.scene.*;
import javafx.geometry.*;
import javafx.scene.effect.*;
import javafx.scene.layout.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;

/**
 * @author Stephen Chin
 */
public class PerspectiveLayout extends Container {
  public var upperLeft:Point2D on replace {
    requestLayout();
  }
  public var upperRight:Point2D on replace {
    requestLayout();
  }
  public var lowerLeft:Point2D on replace {
    requestLayout();
  }
  public var lowerRight:Point2D on replace {
    requestLayout();
  }

  public-init var numColumns:Integer on replace {
    requestLayout();
  }

  public-init var numRows:Integer on replace {
    requestLayout();
  }

  public var cells:Cell[];

  public var perspectiveScale = false on replace {
    requestLayout();
  }

  override var content = bind [
    Rectangle {
      width: bind width
      height: bind height
      fill: Color.TRANSPARENT
    },
    cells as Node[]
  ];

  var boundingPolygons:Polygon[];

  override var onMouseClicked = function(e) {
    nodeAt(e.x, e.y).onMouseClicked(e);
  }

  var nodeIn:Node;
  override var onMouseEntered = function(e) {
    nodeIn = nodeAt(e.x, e.y);
    nodeIn.onMouseEntered(e);
  }
  override var onMouseExited = function(e) {
    nodeIn.onMouseExited(e);
    nodeIn = null;
  }
  override var onMouseMoved = function(e) {
    def nodeOver = nodeAt(e.x, e.y);
    if (nodeIn != nodeOver) {
      nodeIn.onMouseExited(e);
      nodeOver.onMouseEntered(e);
      nodeIn = nodeOver;
    }
    nodeOver.onMouseMoved(e);
  }

  function nodeAt(x:Number, y:Number):Node {
    for (b in boundingPolygons) {
      if (b.contains(x, y)) {
        return cells[indexof b] as Node;
      }
    }
    return null;
  }

  override function doLayout():Void {
    def transform = PerspectiveTransformer {
      upperLeft: upperLeft
      upperRight: upperRight
      lowerLeft: lowerLeft
      lowerRight: lowerRight
    }
    boundingPolygons = for (node in getManaged(cells as Node[])) {
      def cell = node as Cell;
      // initialize as Number to avoid conversion for math later
      def x:Number = cell.x;
      def y:Number = cell.y;
      def upperLeftCorner = transform.transform(Point2D {
        x: x / numColumns
        y: y / numRows
      });
      def upperRightCorner = transform.transform(Point2D {
        x: (x + 1) / numColumns
        y: y / numRows
      });
      def lowerLeftCorner = transform.transform(Point2D {
        x: x / numColumns
        y: (y + 1) / numRows
      });
      def lowerRightCorner = transform.transform(Point2D {
        x: (x + 1) / numColumns
        y: (y + 1) / numRows
      });
      if (perspectiveScale) {
        def resizable = cell as Resizable;
        node.effect = PerspectiveTransform {
          ulx: upperLeftCorner.x
          uly: upperLeftCorner.y
          urx: upperRightCorner.x
          ury: upperRightCorner.y
          llx: lowerLeftCorner.x
          lly: lowerLeftCorner.y
          lrx: lowerRightCorner.x
          lry: lowerRightCorner.y
        }
        resizable.width = resizable.getPrefWidth(-1);
        resizable.height = resizable.getPrefHeight(-1);
      } else {
        def resizable = cell as Resizable;
        def centerPoint = transform.transform(Point2D {
          x: (x + 0.5) / numColumns
          y: (y + 0.5) / numRows
        });
        def transformedWidth = (lowerRightCorner.x - lowerLeftCorner.x) / 2 +
                               (upperRightCorner.x - upperLeftCorner.x) / 2;
        def transformedHeight = (lowerLeftCorner.y - upperLeftCorner.y) / 2 +
                                (lowerRightCorner.y - upperRightCorner.y) / 2;
        def transformedX = centerPoint.x - transformedWidth / 2;
        def transformedY = centerPoint.y - transformedHeight / 2;
        layoutNode(node, transformedX, transformedY, transformedWidth,
                   transformedHeight, HPos.CENTER, VPos.CENTER);
      }
      Polygon {
        points: [
          upperLeftCorner.x, upperLeftCorner.y,
          upperRightCorner.x, upperRightCorner.y,
          lowerRightCorner.x, lowerRightCorner.y,
          lowerLeftCorner.x, lowerLeftCorner.y,
        ]
      }
    }
  }
}
