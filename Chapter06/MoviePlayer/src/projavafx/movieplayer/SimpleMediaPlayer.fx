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
 * SimpleMediaPlayer.fx - Part of an example that illustrates
 * a simple media player.
 *
 * Developed 2009 by Stephen Chin and Dean Iverson
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.movieplayer;

import javafx.scene.Group;
import javafx.scene.media.Media;
import javafx.scene.media.MediaError;
import javafx.scene.media.MediaPlayer;
import javafx.scene.media.MediaView;
import projavafx.movieplayer.MediaPlayerControls;

import javafx.scene.CustomNode;
import javafx.scene.layout.Resizable;

/**
 * A simple media player class that takes the URI of a media file and provides
 * playback controls.
 *
 * @author Stephen Chin
 * @author Dean Iverson
 */
public class SimpleMediaPlayer extends Resizable, CustomNode {
  public var source: String on replace {
    player.media.source = source;
  }

  def player: MediaPlayer = MediaPlayer {
    media: Media {
      source: source
    }
    onError: handleMediaError
    onEndOfMedia: function() {
      player.stop();
      player.currentTime = 0s;
    }
  }

  def GAP = 5.0;

  def mediaHeight = bind player.media.height on replace {
    view.preserveRatio = true;
  }

  def view: MediaView = MediaView {
    translateX: bind (width - view.layoutBounds.width) / 2
    translateY: GAP
    mediaPlayer: player
    fitWidth: bind width - (2 * GAP)
    fitHeight: bind height - (2 * GAP + controls.layoutBounds.height)
    preserveRatio: false
    onError: handleMediaError
  }

  def controls = MediaPlayerControls {
    translateY: bind view.layoutBounds.height + GAP;
    width: bind width
    volume: bind player.volume with inverse
    balance: bind player.balance with inverse
    isPlaying: bind player.status == MediaPlayer.PLAYING
    mediaDuration: bind player.media.duration
    bufferTime: bind player.bufferProgressTime
    currentTime: bind player.currentTime with inverse
    onTogglePlayPause: function( play:Boolean ) {
      if (play) {
        player.play();
      } else {
        player.pause();
      }
    }
    onToggleRepeat: function( repeat:Boolean ) {
      if (repeat) {
        player.repeatCount = MediaPlayer.REPEAT_FOREVER;
      } else {
        player.repeatCount = MediaPlayer.REPEAT_NONE;
      }
    }
  }

  def PREF_WIDTH = 720;
  def PREF_HEIGHT = 480;

  override function getPrefWidth(height) { PREF_WIDTH }
  override function getPrefHeight(width) { PREF_HEIGHT }

  override function create() {
    Group {
      content: [ view, controls ]
    }
  }

  function handleMediaError( me:MediaError ) {
    println( "Error Occurred: {me.message}" );
  } 
}
