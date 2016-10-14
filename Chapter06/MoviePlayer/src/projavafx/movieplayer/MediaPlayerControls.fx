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
 * MediaPlayerControls.fx - Part of an example that illustrates
 * a simple media player.
 *
 * Developed 2009 by Dean Iverson as a JavaFX Script SDK 1.2
 * example for the Pro JavaFX book.
 */

package projavafx.movieplayer;

import javafx.lang.Duration;
import javafx.scene.CustomNode;
import javafx.scene.effect.Glow;
import javafx.scene.Group;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.scene.shape.Line;
import javafx.scene.shape.Rectangle;

/**
 * @author Dean Iverson
 */
public class MediaPlayerControls extends CustomNode {
  public var width = 100.0;
  public var isPlaying = false;
  public var mediaDuration: Duration;
  public var bufferTime: Duration;
  public var currentTime: Duration;
  public var volume = 1.0;
  public var balance = 0.0;
  public var onTogglePlayPause: function( play:Boolean ):Void;
  public var onToggleRepeat: function( repeat:Boolean ):Void;

  var hbox: HBox;

  def percentPlayed = bind currentTime.toSeconds() / mediaDuration.toSeconds();
  def percentBuffered = bind bufferTime.toSeconds() / mediaDuration.toSeconds();
  def height = bind playImg.height;

  def CONTROLS_PADDING = 5;
  def CONTROLS_SPACING = 10;

  def playImg = Image {
    url: "{__DIR__}resources/play.png"
  }

  def pauseImg = Image {
    url: "{__DIR__}resources/pause.png"
  }

  def playPauseButton: ImageView = ImageView {
    def hoverEffect = Glow {}
    image: bind if (isPlaying) pauseImg else playImg
    effect: bind if (playPauseButton.hover) hoverEffect else null
    onMousePressed: function( me:MouseEvent ) {
      onTogglePlayPause( isPlaying == false );
    }
  }

  def repeatButton: ImageView = ImageView {
    var repeat = false;
    def hoverEffect = Glow {}
    def selectedEffect = Glow { level: 0.5 }
    image: Image {
      url: "{__DIR__}resources/repeat.png"
    }
    effect: bind {
      if (repeat) selectedEffect else if (repeatButton.hover) hoverEffect else null
    }
    onMousePressed: function( me:MouseEvent ) {
      repeat = not repeat;
      onToggleRepeat( repeat );
    }
  }

  def progressGroup = Group {
    def progressWidth = bind calcProgressWidth() on replace {
      hbox.requestLayout();
    }
    def setCurrentTimeFromMouseX = function( mouseX ) {
      var newTime = if (mouseX < 0) 0s else mediaDuration * mouseX / progressWidth;
      currentTime = if (newTime < bufferTime) newTime else bufferTime - 1ms;
    }
    content: [
      Rectangle {
        id: "progressBackground"
        width: bind progressWidth
        height: bind height / 2
        onMouseDragged: function(e) {
          setCurrentTimeFromMouseX( e.x );
        }
        onMousePressed: function(e) {
          setCurrentTimeFromMouseX( e.x );
        }
      },
      Rectangle {
        id: "progressBuffer"
        width: bind  percentBuffered * progressWidth
        height: bind height / 2
      },
      Rectangle {
        id: "progressForeground"
        width: bind  percentPlayed * progressWidth
        height: bind height / 2
      },
      Line {
        id: "progressIndicator"
        startY: 1
        endY: bind height / 2 - 1
        startX: bind percentPlayed * (progressWidth - 1)
        endX: bind percentPlayed * (progressWidth - 1)
      },
      Slider {
        width: bind (progressWidth - CONTROLS_SPACING) / 2
        translateY: (height + CONTROLS_SPACING) / 2
        maxValue: 1.0
        currentValue: bind volume with inverse
        styleClass: "mediaSlider"
      },
      Slider {
        width: bind (progressWidth - CONTROLS_SPACING) / 2
        translateX: bind (progressWidth + CONTROLS_SPACING) / 2
        translateY: (height + CONTROLS_SPACING) / 2
        minValue: -1.0
        maxValue: 1.0
        currentValue: bind balance with inverse
        styleClass: "mediaSlider"
      }
    ]
  }

  var progressGroupWidth = bind progressGroup.layoutBounds.width on replace {
    hbox.requestLayout();
  }

  bound function calcProgressWidth() {
    width - (playImg.width + playImg.width) - (2 * CONTROLS_SPACING) -
        (2 * CONTROLS_PADDING);
  }

  override function create() {
    Group {
      content: [
        hbox = HBox {
          translateX: CONTROLS_PADDING
          translateY: CONTROLS_PADDING
          spacing: CONTROLS_SPACING
          content: [
            playPauseButton,
            progressGroup,
            repeatButton
          ]
        }
      ]
    }
  }
}