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
 * FullScreenMoviePlayer - Part of an example that illustrates
 * the basics of playing a movie in JavaFX.
 *
 * Developed 2009 by Dean Iverson as a JavaFX Script SDK 1.2
 * example for the Pro JavaFX book.
 */

package projavafx.fullscreenmovieplayer;

import javafx.lang.FX;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.media.Media;
import javafx.scene.media.MediaPlayer;
import javafx.scene.media.MediaView;
import javafx.scene.paint.Color;
import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 * @author Dean Iverson
 */
var theScene: Scene;
var theView: MediaView;

var mediaHeight = bind theView.mediaPlayer.media.height on replace {
  if (mediaHeight > 0 and not theView.preserveRatio) {
    theView.preserveRatio = true;
  }
}

Stage {
  fullScreen: true
  scene: theScene = Scene {
    fill: Color.BLACK
    content: [
      theView = MediaView {
        layoutX: bind (theScene.width - theView.layoutBounds.width) / 2
        layoutY: bind (theScene.height - theView.layoutBounds.height) / 2
        fitWidth: bind theScene.width
        fitHeight: bind theScene.height
        preserveRatio: false
        mediaPlayer: MediaPlayer {
          autoPlay: true
          media: Media {
            source: "http://projavafx.com/movies/elephants-dream-640x352.flv"
          }
        }
        focusTraversable: true
        onKeyPressed: function( ke:KeyEvent ) {
          if (ke.code == KeyCode.VK_Q) {
            FX.exit();
          }
        }
      }
    ]
  }
}
