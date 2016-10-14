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
 * MoviePlayer - A JavaFX Script example program that demonstrates
 * how to play an video file.
 *
 * Developed 2009 by Dean Iverson as a JavaFX Script SDK 1.2 example
 * for the Pro JavaFX book.
 */

package projavafx.movieplayer;

import javafx.lang.FX;
import javafx.scene.Scene;
import javafx.stage.Stage;

// See if there is an command line argument for the media file
var uriString = FX.getArguments()[0];

if (uriString == null or uriString.length() == 0) {
  uriString = "http://projavafx.com/movies/elephants-dream-640x352.flv";
}

Stage {
  var theScene: Scene;
  title: "MoviePlayer"
  scene: theScene = Scene {
    width: 864
    height: 400
    stylesheets: "{__DIR__}audioPlayer.css"
    content: SimpleMediaPlayer {
      source: uriString
      width: bind theScene.width
      height: bind theScene.height
    }
  }
}

