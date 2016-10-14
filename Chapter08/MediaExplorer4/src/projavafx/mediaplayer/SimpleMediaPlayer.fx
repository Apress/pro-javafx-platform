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
 * SimpleMoviePlayer.fx - Part of the Movie Widget example that illustrates
 * a simple media player that can be run as a desktop widget complete with
 * configuration and skinning support.
 *
 * Developed 2009 by Stephen Chin
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.mediaplayer;

import javafx.animation.transition.FadeTransition;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.media.Media;
import javafx.scene.media.MediaPlayer;
import javafx.scene.media.MediaView;
import javafx.scene.layout.Resizable;
import javafx.scene.paint.Color;
import javafx.scene.shape.Line;
import javafx.scene.shape.Rectangle;

/**
 * A simple media player class that takes a media file on initialization, and
 * creates a custom node that contains a MediaView instance.  This class adds
 * a simple seek bar that is a full-screen transparent overlay that hides when
 * the mouse is not over the player window.
 *
 * @author Stephen Chin
 */
public class SimpleMediaPlayer extends CustomNode, Resizable {
    public-init var media: Media;

    public-init var player: MediaPlayer;

    public-read var mediaView: MediaView;

    var currentX: Number;

    override function getPrefWidth(height) {media.width}
    override function getPrefHeight(width) {media.height}
    override function getMaxWidth() {Double.MAX_VALUE}
    override function getMaxHeight() {Double.MAX_VALUE}

    var progressGroup = Group {
        content: [
            Rectangle {
                width: bind player.currentTime.toSeconds() / player.media.duration.toSeconds() * mediaView.layoutBounds.width
                height: bind mediaView.layoutBounds.height
                opacity: 0.25
                fill: Color.BLACK
            }
            Line {
                endY: bind mediaView.layoutBounds.height
                startX: bind currentX
                endX: bind currentX
                stroke: Color.BLACK
            }
        ]
        clip: Rectangle {
            width: bind mediaView.layoutBounds.width
            height: bind mediaView.layoutBounds.height
        }
    }

    var fadeTransition = FadeTransition {
        duration: 500ms
        node: progressGroup
        fromValue: 0
        toValue: 1
    }

    var progressVisible = bind mediaView.hover or mediaView.pressed on replace {
        fadeTransition.rate = if (progressVisible) then 1 else -1;
        fadeTransition.play();
    }

    init {
        if (not isInitialized(player)) {
            player = MediaPlayer {
                media: media
            }
            FX.deferAction(function():Void {
                player.play();
            });
        } else {
            media = player.media;
        }
    }

    override var onMouseDragged = function(e) {
        currentX = e.x;
        player.currentTime = player.media.duration * e.x / mediaView.layoutBounds.width
    }
    override var onMouseMoved = function(e) {
        currentX = e.x;
    }
    override var onMousePressed = function(e) {
        currentX = e.x;
        player.currentTime = player.media.duration * e.x / mediaView.layoutBounds.width
    }
    override var onMouseReleased = function(e) {
        if (player.status != MediaPlayer.PLAYING) {
            player.play();
        }
    }

    override function create() {
        Group {
            content: [
                mediaView = MediaView {
                    fitWidth: bind width
                    fitHeight: bind height
                    mediaPlayer: bind player
                },
                progressGroup
            ]
        }
    }
}
