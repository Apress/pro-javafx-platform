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
 */
package projavafx.bookstorefx.ui;

import javafx.animation.Timeline;
import javafx.animation.transition.FadeTransition;
import javafx.scene.Scene;
import javafx.stage.Stage;
import projavafx.bookstorefx.model.BookStoreModel;
import projavafx.bookstorefx.ui.CartPage;
import projavafx.bookstorefx.ui.HomePage;
import projavafx.bookstorefx.ui.NodeFactory;
import projavafx.bookstorefx.ui.SearchPage;
import projavafx.bookstorefx.ui.SlideDeck;

/**
 * @author Dean Iverson
 */
var sceneRef:Scene;
var model = BookStoreModel { }
var slideDeck: SlideDeck;
var logo = NodeFactory.getLogo();

var busyAnimation = FadeTransition {
  node: logo
  duration: 0.5s
  fromValue: 1.0
  toValue: 0.3
  autoReverse: true
  repeatCount: Timeline.INDEFINITE
}

var busy = bind model.busy on replace {
  if (busy) {
    busyAnimation.playFromStart();
  } else {
    busyAnimation.stop();
    logo.opacity = 1.0;

    // Reapply the styles to the scene
    delete sceneRef.stylesheets;
    sceneRef.stylesheets = "{__DIR__}bookStoreStyles.css";
  }
}

Stage {
  title: "BookStoreFX"
  resizable: false
  scene: sceneRef = Scene {
    width: 1024
    height: 900
    stylesheets: "{__DIR__}bookStoreStyles.css"
    content: [
      NodeFactory.getBackground(),
      logo,
      NodeFactory.getHeader(showPage(0), showPage(1), showPage(2)),
      slideDeck = SlideDeck {
        def homePage = HomePage { model: model }
        def searchPage = SearchPage { model: model }
        def cartPage = CartPage { }

        content: [ homePage, searchPage, cartPage ]
        inTransitions: [
          homePage.pageInTransition(),
          searchPage.pageInTransition(),
          cartPage.pageInTransition()
        ]
        outTransitions: [
          homePage.pageOutTransition(),
          searchPage.pageOutTransition(),
          cartPage.pageOutTransition()
        ]
      }
    ]
  }
}

function showPage( index:Integer ): function() {
  function() {
    slideDeck.slideIndex = index;
  }
}
