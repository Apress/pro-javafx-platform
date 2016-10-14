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
 * ColorPickerSnowFlakeNode.fx - A graphical node that enables choosing a color,
 * where the colors are arranged in a snowflake pattern
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.colorpicker.ui;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.control.Button;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Line;
import javafx.scene.shape.Polygon;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.*;
import javafx.scene.transform.Rotate;
import javafx.scene.transform.Translate;
import javafx.util.Math;

/**
 * A drawing tool that, when selected, indicates that the user wants to
 * draw a Circle.
 */
public class ColorPickerSnowFlakeNode extends CustomNode {

  /**
   * Width of the diamonds shapes in the color picker
   */
  public-init var diamondWidth: Double = 20;

  /**
   * Sequence of RGB values that are in the 216 "Web safe" colors
   */
  def rgbNums: Number[] = [0xFF, 0xCC, 0x99, 0x66, 0x33, 0x00];

  /**
   * The title of the color picker
   */
  public var title: String;

  /**
   * The chosen red value
   */
  public var chosenRedNum: Number;

  /**
   * The chosen green value
   */
  public var chosenGreenNum: Number;

  /**
   * The chosen blue value
   */
  public var chosenBlueNum: Number;

  /**
   * The chosen color
   */
  public var chosenColor: Color;

  /**
   * The original color
   */
  public var originalColor: Color;

  /**
   * Override the visible instance variable so it can put itself
   * on top when it becomes visible
   */
  public override var visible on replace {
    if (visible) toFront();
  }

  /**
   * The onClose function attribute is executed when the
   * the OK or Cancel button is pressed, passing the chosen color
   * or original color, depending upon which button was pressed
   */
  public var onClose: function(color:Color):Void;

  /**
   * Create the Node
   */
  override public function create():Node {
    Group {
      def TITLE_BAR_HEIGHT: Number = diamondWidth * 1.5;
      var colorValFont = Font.font("Sans serif", FontWeight.BOLD, diamondWidth * 0.8)
      var outerRectRef: Rectangle
      var buttonsHBoxRef: HBox
      var titleTextRef: Text
      content: [
        outerRectRef = Rectangle {
          var startDragX: Number = 0;
          var startDragY: Number = 0;
          blocksMouse: true
          width: 20 * diamondWidth
          height: 26 * diamondWidth
          fill: Color.WHITE
          stroke: Color.BLACK
          arcHeight: 30
          arcWidth: 30
          onMousePressed: function(me:MouseEvent) {
            toFront();
            startDragX = localToScene(boundsInLocal).minX + 10;
            startDragY = localToScene(boundsInLocal).minY + 10;
          }
          onMouseDragged: function(me:MouseEvent) {
            translateX = me.dragX + startDragX;
            translateY = me.dragY + startDragY;
          }
        },
        Line {
          startX: 0
          startY: TITLE_BAR_HEIGHT
          endX: 20 * diamondWidth - 1
          endY: TITLE_BAR_HEIGHT
          stroke: Color.BLACK
          strokeWidth: 1
        },
        titleTextRef = Text {
          translateX: bind (outerRectRef.layoutBounds.width -
          titleTextRef.layoutBounds.width) / 2
          translateY: bind (TITLE_BAR_HEIGHT -
          titleTextRef.layoutBounds.height) / 2
          textOrigin: TextOrigin.TOP
          content: bind title
          fill: Color.BLACK
          font: Font.font("Sans serif", FontWeight.BOLD, 1.2 * diamondWidth)
        },
        Group {
          blocksMouse: true
          content: bind for (rNum in rgbNums) {
            Group {
              def diamondHalfHeight: Double =
                      Math.sqrt(Math.pow(diamondWidth, 2) -
                      Math.pow(diamondWidth / 2, 2))
              def diamondHalfWidth: Double = diamondWidth / 2
              transforms: [
                Translate.translate(10 * diamondWidth, 12.75 * diamondWidth),
                Rotate.rotate(indexof rNum * 60, 0, 0)
              ]
              content: for (gNum in rgbNums) {
                for (bNum in rgbNums) {
                  Group {
                    var polyRef: Polygon
                    translateX: indexof bNum * diamondHalfWidth -
                                indexof gNum * diamondHalfWidth
                    translateY: indexof bNum * diamondHalfHeight +
                                indexof gNum * diamondHalfHeight
                    content: [
                      polyRef = Polygon {
                        points: [
                          0, 0,
                          diamondHalfWidth, diamondHalfHeight,
                          0, diamondHalfHeight * 2,
                          diamondHalfWidth * - 1, diamondHalfHeight
                        ]
                        fill: Color.rgb(rNum, gNum, bNum)
                        stroke: bind if (polyRef.hover)
                                      Color.rgb((rNum + 128) mod 256,
                                                (gNum + 128) mod 256,
                                                (bNum + 128) mod 256)
                                     else null
                        strokeWidth: 2
                        onMouseClicked: function(me:MouseEvent) {
                          chosenRedNum = rNum;
                          chosenGreenNum = gNum;
                          chosenBlueNum = bNum;
                          chosenColor = Color.rgb(rNum, gNum, bNum);
                        }
                      },
                    ]
                  }
                }
              }
            }
          }
        },
        HBox {
          translateX: 13.5 * diamondWidth
          translateY: 2.5 * diamondWidth
          spacing: 10
          content: [
            Rectangle {
              width: 1.5 * diamondWidth
              height: 2.5 * diamondWidth
              arcWidth: 10
              arcHeight: 10
              stroke: Color.BLACK
              fill: bind if (chosenColor != null) chosenColor
                         else originalColor
            },
            VBox {
              opacity: bind if (chosenColor == null) 0.0 else 1.0
              content: [
                Text {
                  font: colorValFont
                  textOrigin: TextOrigin.TOP
                  content: bind "r:{chosenRedNum as Integer}"
                },
                Text {
                  font: colorValFont
                  textOrigin: TextOrigin.TOP
                  content: bind "g:{chosenGreenNum as Integer}"
                },
                Text {
                  font: colorValFont
                  textOrigin: TextOrigin.TOP
                  content: bind "b:{chosenBlueNum as Integer}"
                }
              ]
            }
          ]
        },
        buttonsHBoxRef = HBox {
          blocksMouse: true
          layoutX: bind outerRectRef.layoutBounds.width -
                           buttonsHBoxRef.layoutBounds.width - 10
          layoutY: bind outerRectRef.layoutBounds.height -
                           buttonsHBoxRef.layoutBounds.height - 10
          spacing: 5
          content: [
            Button {
              text: "OK"
              action: function():Void {
                visible = false;
                onClose(chosenColor);
              }
            },
            Button {
              text: "Cancel"
              action: function():Void {
                // Revert to the original color
                visible = false;
                chosenColor = originalColor;
                onClose(chosenColor);
              }
            }
          ]
        }
      ]
    }
  }
}
