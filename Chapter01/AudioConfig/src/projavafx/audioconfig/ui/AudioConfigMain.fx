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
 * AudioConfigMain.fx - A JavaFX Script example program that demonstrates
 * "the way of JavaFX" (binding to model classes, triggers, sequences, and
 * declaratively expressed, node-centric UIs).  Note: Because this example
 * covers beginning JavaFX concepts, it is more verbose than necessary.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.audioconfig.ui;

import javafx.ext.swing.SwingComboBox;
import javafx.ext.swing.SwingComboBoxItem;
import javafx.scene.*;
import javafx.scene.control.Slider;
import javafx.scene.control.CheckBox;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.text.*;
import javafx.stage.Stage;
import projavafx.audioconfig.model.AudioConfigModel;

Stage {
  def acModel = AudioConfigModel {
    selectedDecibels: 35
  }
  title: "Audio Configuration"
  scene: Scene {
    content: [
      Rectangle {
        // No need to assign 0 to x and y, because 0 is the default
        width: 320
        height: 45
        fill: LinearGradient {
          // No need to assign 0 to startX and startY, because 0 is default
          endX: 0.0
          endY: 1.0
          stops: [
            Stop {
              color: Color.web("0xAEBBCC")
              offset: 0.0
            },
            Stop {
              color: Color.web("0x6D84A3")
              offset: 1.0
            }
          ]
        }
      },
      Text {
        layoutX: 65
        layoutY: 12
        textOrigin: TextOrigin.TOP
        fill: Color.WHITE
        content: "Audio Configuration"
        font: Font.font("SansSerif", FontWeight.BOLD, 20)
      },
      Rectangle {
        x: 0  // 0 is default, so assigning here just for clarity
        y: 43
        width: 320
        height: 300
        fill: Color.rgb(199, 206, 213)
      },
      Rectangle {
        x: 9
        y: 54
        width: 300
        height: 130
        arcWidth: 20
        arcHeight: 20
        fill: Color.WHITE
        stroke: Color.color(0.66, 0.67, 0.69)
      },
      Text {
        layoutX: 18
        layoutY: 69
        textOrigin: TextOrigin.TOP
        fill: Color.web("0x131021")
        content: bind "{%1.0f acModel.selectedDecibels} dB"
        font: Font.font("SansSerif", FontWeight.BOLD, 18)
      },
      Slider {
        layoutX: 135
        layoutY: 69
        width: 162
        disable: bind acModel.muting
        min: bind acModel.minDecibels
        max: bind acModel.maxDecibels
        value: bind acModel.selectedDecibels with inverse
      },
      Line {
        startX: 9
        startY: 97
        endX: 309
        endY: 97
        stroke: Color.color(0.66, 0.67, 0.69)
      },
      Text {
        layoutX: 18
        layoutY: 113
        textOrigin: TextOrigin.TOP
        fill: Color.web("0x131021")
        content: "Muting"
        font: Font.font("SansSerif", FontWeight.BOLD, 18)
      },
      CheckBox {
        layoutX: 280
        layoutY: 113
        selected: bind acModel.muting with inverse
      },
      Line {
        startX: 9
        startY: 141
        endX: 309
        endY: 141
        stroke: Color.color(0.66, 0.67, 0.69)
      },
      Text {
        layoutX: 18
        layoutY: 157
        textOrigin: TextOrigin.TOP
        fill: Color.web("0x131021")
        content: "Genre"
        font: Font.font("SansSerif", FontWeight.BOLD, 18)
      },
      SwingComboBox {
        layoutX: 204
        layoutY: 148
        width: 93
        items: bind for (genre in acModel.genres) {
          SwingComboBoxItem {
            text: genre
          }
        }
        selectedIndex: bind acModel.selectedGenreIndex with inverse
      }
    ]
  }
}
