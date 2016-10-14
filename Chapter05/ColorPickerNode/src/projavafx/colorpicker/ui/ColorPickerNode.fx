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
 * ColorPickerNode.fx - A graphical node that shows the 216 "web-safe" colors
 * arranged in 6 squares of 36 colors each.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.colorpicker.ui;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.text.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;

/**
 * A graphical node that shows the 216 "web-safe" colors
 * arranged in 6 squares of 36 colors each.
 */
public class ColorPickerNode extends CustomNode {

  /**
   * Sequence of RGB values that are in the 216 "Web safe" colors
   */
  def rgbNums: Number[] = [0x00, 0x33, 0x66, 0x99, 0xCC, 0xFF];

  /**
   * Create the Node
   */
  override public function create():Node {
    Group {
      content: bind for (rNum in rgbNums) {
        Group {
          def SQUARE_WIDTH: Number = 15
          layoutY: indexof rNum * (SQUARE_WIDTH * sizeof rgbNums +
                                      SQUARE_WIDTH)
          content: for (gNum in rgbNums) {
            for (bNum in rgbNums) {
              Group {
                var rectRef: Rectangle
                content: [
                  rectRef = Rectangle {
                    x: indexof gNum * SQUARE_WIDTH
                    y: indexof bNum * SQUARE_WIDTH
                    width: SQUARE_WIDTH
                    height: SQUARE_WIDTH
                    fill: Color.rgb(rNum, gNum, bNum)
                  },
                  Text {
                    textOrigin: TextOrigin.BOTTOM
                    visible: bind rectRef.hover
                    font: Font.font("Sans serif", FontWeight.BOLD, 14)
                    content: "rNum:{%1.0f rNum}, "
                             "gNum: {%1.0f gNum}, "
                             "bNum: {%1.0f bNum}"

                  }
                ]
              }
            }
          }
        }
      }
    }
  }
}
