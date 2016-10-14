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
 *  ButtonNode.fx -
 *  A node that functions as an image button
 *
 *  Developed 2008 by James L. Weaver (jim.weaver at javafxpert.com)
 *  and Edgar Merino (http://devpower.blogsite.org/) to demonstrate how
 *  to create custom nodes in JavaFX
 */

package com.javafxpert.custom_node;

import javafx.animation.Interpolator;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.input.MouseEvent;
import javafx.scene.effect.Glow;
import javafx.scene.shape.Rectangle;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;

public class ImageViewButtonNode extends CustomNode {
    /**
    * The title for this button
     */
    public var title: String;

    /**
    * The Image for this button
     */
    var btnImage: Image;

    /**
    * The ImageView (if supplied) for the button
     */
    public var imageView: Node;
    //public var imageView: ImageView;

    /**
    * The percent of the original image size to show when mouse isn't
     * rolling over it.
     * Note: The image will be its original size when it's being
     * rolled over.
     */
    public var scale: Number = 0.9;

    /**
    * The opacity of the button when not in a rollover state
     */
    public var opacityValue: Number = 0.8;

    /**
    * The opacity of the text when not in a rollover state
     */
    public var textOpacityValue: Number = 0.0;

    /**
    * Determines whether this button is enabled
     */
    public var enabled: Boolean = true;

    /**
    * A Timeline to control fading behavior when mouse enters or exits a button
     */
    public var fadeTimeline = Timeline {
        keyFrames: [
            KeyFrame {
                time: 500ms
                values: [
                    scale => 1.0 tween Interpolator.LINEAR,
                    opacityValue => 1.0 tween Interpolator.LINEAR,
                    textOpacityValue => 1.0 tween Interpolator.LINEAR
                ]
            }
        ]
    };

    /**
    * This attribute is interpolated by a Timeline, and various
     * attributes are bound to it for fade-in behaviors
     */
    var fade: Number = 1.0;

    /**
    * This attribute represents the state of whether the mouse is inside
     * or outside the button, and is used to help compute opacity values
     * for fade-in and fade-out behavior.
     */
    var mouseInside: Boolean;

    /**
     * The action function attribute that is executed when the
     * the button is pressed
     */
    public var action: function():Void;

    /**
    * Create the Node
    */
    public override function create():Node {
        Group {
            content: bind [
                Rectangle {
                    translateX: imageView.layoutBounds.minX
                    translateY: imageView.layoutBounds.minY
                    //TODO: Avoid hardcoding
                    width: bind imageView.layoutBounds.width
                    height: bind imageView.layoutBounds.height
                    //width: 18
                    //height: 20
                    //width: 118
                    //height: 120
                    opacity: 0.0
                    //fill: Color.BLUE
                },
                Group {
                    content: imageView
                    opacity: bind if (enabled) opacityValue else 0.3
                    /*
                    onMouseEntered:
                        function(me:MouseEvent):Void {
                            mouseInside = true;
                            fadeTimeline.rate = 1.0;
                            fadeTimeline.play();
                        }
                    onMouseExited:
                        function(me:MouseEvent):Void {
                            mouseInside = false;
                            fadeTimeline.rate = -1.0;
                            fadeTimeline.play();
                            me.node.effect = null
                        }
                    onMousePressed:
                        function(me:MouseEvent):Void {
                            me.node.effect = Glow {
                            level: 0.9
                        };
                    onMouseReleased:
                        function(me:MouseEvent):Void {
                            me.node.effect = null;
                            if (enabled) action();
                        }
                    onMouseClicked:
                        function(me:MouseEvent):Void {
                            action();
                        }
                    */
                },
            ]
        }
    }
}