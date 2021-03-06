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
 *  HelloEarthRiseMain.fx - A JavaFX Script "Hello World" style example
 *
 *  Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 *  as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.helloearthrise.ui;

import javafx.animation.transition.TranslateTransition;
import javafx.animation.*;
import javafx.stage.Stage;
import javafx.scene.*;
import javafx.scene.image.*;
import javafx.scene.media.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.*;

var textRef:Text;

// Provides the animated scrolling behavior for the text
var transTransition = TranslateTransition {
  duration: 75s
  node: bind textRef
  toY: bind -(textRef.layoutBounds.height + 85)
  interpolator: Interpolator.LINEAR
  repeatCount: Timeline.INDEFINITE
}

var scene:Scene;
def borderWidth = bind scene.width * .10;
Stage {
  title: "Hello Earthrise"
  scene: scene = Scene {
    var image:Image;
    var imageView:ImageView;
    content: [
      imageView = ImageView {
        x: bind if (scene.width == 0) then 0 else (scene.width - image.width) / 2
        y: bind if (scene.height == 0) then 0 else (scene.height - image.height) / 2
        image: image = Image {
          url: "http://projavafx.com/images/earthrise.jpg"
        }
      },
      Group {
        layoutX: bind borderWidth
        layoutY: bind imageView.layoutBounds.minY + 180
        content: [
          textRef = Text {
            layoutY: 100
            textOrigin: TextOrigin.TOP
            textAlignment: TextAlignment.JUSTIFY
            wrappingWidth: bind (if (scene.width == 0) then image.width
                                 else scene.width) - borderWidth * 2
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
            font: bind Font.font("SansSerif", FontWeight.BOLD, scene.width * .05);
          }
        ]
        clip:
          Rectangle {
            width: bind scene.width
            height: 85
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
