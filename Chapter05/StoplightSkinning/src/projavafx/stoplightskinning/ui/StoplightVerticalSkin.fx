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
 * StoplightVerticalSkin.fx - A JavaFX Script example program that
 * demonstrates how to create a skinnable UI control.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * and Chris Wright chris.wright [at] veriana.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.stoplightskinning.ui;

import javafx.scene.Group;
import javafx.scene.control.Skin;
import javafx.scene.effect.Glow;
import javafx.scene.effect.DropShadow;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.*;
import javafx.scene.layout.VBox;
import javafx.scene.shape.Circle;
import javafx.scene.shape.Rectangle;

/**
 * The skin for a vertical StopLight
 */
public class StoplightVerticalSkin extends Skin {

  /**
   * Reference to the Stoplight control
   */
  public var stoplightControl:Stoplight = bind control as Stoplight;

  /**
   * Reference to the Stoplight behavior
   */
  override var behavior = StoplightBehavior {};

  override public function intersects(localX:Number, localY:Number,
      localWidth:Number, localHeight:Number):Boolean {
    return node.intersects(localX, localY, localWidth, localHeight);
  }

  override public function contains(localX: Number, localY:Number):Boolean {
    return node.contains(localX, localY);
  }

  init {
    node = Group {
      focusTraversable: true
      content: [
        Rectangle {
          width: 100
          height: 240
          fill: Color.BLUE
          stroke: Color.BLACK
          strokeWidth: 2
          // Make the stroke a dashed line if the control has focus
          strokeDashArray: bind if (stoplightControl.focused)
                                   [8, 8]
                                else [1]
        },
        VBox {
          layoutX: 25
          layoutY: 25
          spacing: 10
          content: [
            Circle {
              radius: 30
              fill: Color.DARKRED
              effect: bind
                if (stoplightControl.selectedIndex == Stoplight.STOP)
                  Glow {
                    level: 0.8
                  }
                else null
            },
            Circle {
              radius: 30
              fill: Color.DARKORANGE
              effect: bind
                if (stoplightControl.selectedIndex == Stoplight.CAUTION)
                  Glow {
                    level: 0.8
                  }
                else null
            },
            Circle {
              radius: 30
              fill: Color.DARKGREEN
              effect: bind
                if (stoplightControl.selectedIndex == Stoplight.GO)
                  Glow {
                    level: 0.8
                  }
                else null
            }
          ]
        }
      ]
      effect: bind if (stoplightControl.hover)
                     DropShadow {}
                   else null
      onMousePressed: function(me:MouseEvent):Void {
        (behavior as StoplightBehavior).facePressed();
      }
    };
  }
}
