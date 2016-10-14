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
 * ColorPickerMain.fx - A program that displays the ColorPickerSnowFlakeNode
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.colorpicker.ui;

import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

Stage {
  var sceneColor: Color = Color.WHITE
  var colorPicker: ColorPickerSnowFlakeNode
  title: "ColorPickerSnowFlakeMain"
  scene: Scene {
    width: 500
    height: 550
    fill: bind sceneColor
    content: [
      Button {
        text: "Choose Color"
        action: function():Void {
          colorPicker.visible = true;
        }
      },
      colorPicker = ColorPickerSnowFlakeNode {
        layoutX: 50
        layoutY: 50
        title: "Fill Color"
        visible: false
        originalColor: bind sceneColor
        onClose: function(color:Color) {
          sceneColor = color;
        }
      }
    ]
  }
}