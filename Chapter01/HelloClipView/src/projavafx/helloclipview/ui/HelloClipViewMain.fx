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
 *  HelloClipViewMain.fx - A JavaFX Script example that demonstrates
 *  how to use the ClipView layout container
 *
 *  Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *  as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.helloclipview.ui;

import javafx.animation.transition.TranslateTransition;
import javafx.animation.*;
import javafx.stage.Stage;
import javafx.scene.*;
import javafx.scene.image.*;
import javafx.scene.layout.ClipView;
import javafx.scene.media.*;
import javafx.scene.paint.Color;
import javafx.scene.text.*;

var textRef:Text;

// Provides the animated scrolling behavior for the text
var transTransition = TranslateTransition {
  duration: 75s
  node: bind textRef
  toY: -820
  interpolator: Interpolator.LINEAR
  repeatCount: Timeline.INDEFINITE
}

Stage {
  title: "Hello ClipView"
  scene: Scene {
    height: 387
    width: 516
    content: [
      ImageView {
        image: Image {
          url: "http://projavafx.com/images/earthrise.jpg"
        }
      },
      ClipView {
        layoutX: 50
        layoutY: 180
        width: 430
        height: 85
        node:
          textRef = Text {
            layoutY: 100
            textOrigin: TextOrigin.TOP
            textAlignment: TextAlignment.JUSTIFY
            wrappingWidth: 380
            // Note that this syntax creates one long string of text
            content: "Earthrise at Christmas: "
                     "[Forty] years ago this Christmas, a turbulent world "
                     "looked to the heavens for a unique view of our home "
                     "planet. This photo of Earthrise over the lunar horizon "
                     "was taken by the Apollo 8 crew in December 1968, showing "
                     "Earth for the first time as it appears from deep space. "
                     "Astronauts Frank Borman, Jim Lovell and William Anders "
                     "had become the first humans to leave Earth orbit, "
                     "entering lunar orbit on Christmas Eve. In a historic live "
                     "broadcast that night, the crew took turns reading from "
                     "the Book of Genesis, closing with a holiday wish from "
                     "Commander Borman: \"We close with good night, good luck, "
                     "a Merry Christmas, and God bless all of you -- all of "
                     "you on the good Earth.\""
            // The approximate color used in the scrolling Star Wars intro
            fill: Color.rgb(187, 195, 107)
            font: Font.font("SansSerif", FontWeight.BOLD, 24);
          }
      }
    ]
  }
}
// Start playing an audio clip
MediaPlayer {
  autoPlay: true
  repeatCount: MediaPlayer.REPEAT_FOREVER
  media: Media {
    source: "http://projavafx.com/audio/zarathustra.mid"
  }
}
// Start the text animation
transTransition.play();
