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
 * StoplightSkinningMain.fx - A JavaFX Script example program that
 * demonstrates how to create a skinnable UI control.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.stoplightskinning.ui;

import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.scene.control.RadioButton;
import javafx.scene.control.ToggleGroup;

var sceneRef: Scene;

var stoplightControl = Stoplight{};
var verticalSelected:Boolean = true on replace {
  if (verticalSelected) {
    stoplightControl.skin = StoplightVerticalSkin{};
  }
};
var horizontalSelected:Boolean = false on replace {
  if (horizontalSelected) {
    stoplightControl.skin = StoplightHorizontalSkin{};
  }
};

Stage {
  title: "Stoplight Skinning"
  scene: sceneRef = Scene {
    width: 500
    height: 300
    content: Group {
      content: [
        HBox {
          layoutX: 10
          layoutY: 10
          spacing: 20
          content: [
            VBox {
              var toggleGrp = ToggleGroup{}
              spacing: 10
              content: [
                RadioButton {
                  text: "Vertical Skin"
                  toggleGroup: toggleGrp
                  selected: bind verticalSelected with inverse
                },
                RadioButton {
                  text: "Horizontal Skin"
                  toggleGroup: toggleGrp
                  selected: bind horizontalSelected with inverse
                }
              ]
            },
            stoplightControl
          ]
        }
      ]
    }
  }
}
