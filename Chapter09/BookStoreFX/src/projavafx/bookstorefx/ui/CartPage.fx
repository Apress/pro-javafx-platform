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
 * CartPage.fx
 *
 * Created on Mar 7, 2009, 10:47:34 AM
 */

package projavafx.bookstorefx.ui;

import javafx.animation.Timeline;
import javafx.scene.CustomNode;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.scene.transform.Scale;
import projavafx.bookstorefx.ui.MoneyBagUI;

/**
 * @author Dean Iverson
 */
public class CartPage extends CustomNode {
  def moneyBag = MoneyBagUI {}
  var hbox: HBox;

  public function pageInTransition() {
    Timeline {
      keyFrames: [
        at( 0.0s ) { hbox.opacity => 0.0 }
        at( 0.25s ) { hbox.opacity => 1.0 }
      ]
    }
  }

  public function pageOutTransition() {
    Timeline {
      keyFrames: [
        at( 0.0s ) { hbox.opacity => 1.0 }
        at( 0.25s ) { hbox.opacity => 0.0 }
      ]
    }
  }

  override function create() {
    moneyBag.scaleX = 0.5;
    moneyBag.scaleY = 0.5;
    
    hbox = HBox {
      opacity: 0.0
      spacing: 20
      translateX: bind (hbox.scene.width - hbox.layoutBounds.width) / 2
      translateY: bind (hbox.scene.height - hbox.layoutBounds.height) / 2
      content: [
        moneyBag,
        VBox {
          translateY: 140
          spacing: 10
          content: [
            Text {
              wrappingWidth: 300
              content: "Keep your money.  We don't want it.\n"
              styleClass: "cartPageText"
            }
            Text {
              wrappingWidth: 300
              content: "But if you have your heart set on buying a book, "
                       "I hear that Pro JavaFX Platform is a pretty good one."
              styleClass: "cartPageText"
            }
            Text {
              wrappingWidth: 300
              content: "And they say that the authors are really nice guys!"
              styleClass: "cartPageText"
            }
          ]
        }
      ]
    }
  }
}
