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
 * MediaViewer.fx - A JavaFX Script example program that
 * demonstrates how to build a rich Media Explorer application
 * that leverages layouts and utilities from the JFXtras project.
 *
 * Developed 2009 by Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.mediaexplorer;

import javafx.util.Math;
import javafx.animation.transition.ScaleTransition;
import javafx.animation.transition.TranslateTransition;
import javafx.scene.paint.Color;
import org.jfxtras.scene.layout.Deck;
import org.jfxtras.scene.ResizableCustomNode;
import org.jfxtras.scene.shape.ResizableRectangle;
import projavafx.mediaexplorer.view.FileView;

/**
 * @author Stephen Chin
 */
public class MediaViewer extends ResizableCustomNode {

    var mediaViews:FileView[];

    public function showView(view:FileView) {
        view.blocksMouse = true;
        insert view into mediaViews;
        var bounds = view.fromNode.localToScene(view.fromNode.boundsInLocal);
        TranslateTransition {
            duration: 1s
            node: view
            fromX: (bounds.minX + bounds.maxX - scene.width) / 2
            fromY: (bounds.minY + bounds.maxY - scene.height) / 2
            toX: 0
            toY: 0
        }.play();
        ScaleTransition {
            def scale = Math.max(bounds.width / scene.width,
                                 bounds.height / scene.height);
            duration: 1s
            node: view
            fromX: scale
            fromY: scale
            toX: 1
            toY: 1
        }.play();
    }

    public function closeView(view:FileView) {
        var bounds = view.fromNode.localToScene(view.fromNode.boundsInLocal);
        TranslateTransition {
            duration: 500ms
            node: view
            toX: (bounds.minX + bounds.maxX - scene.width) / 2
            toY: (bounds.minY + bounds.maxY - scene.height) / 2
        }.play();
        ScaleTransition {
            def scale = Math.max(bounds.width / scene.width,
                                 bounds.height / scene.height);
            duration: 500ms
            node: view
            toX: scale
            toY: scale
            action: function() {
                view.onClose();
                delete view from mediaViews;
            }
        }.play();
    }

    var backgroundRectangle = ResizableRectangle {
        fill: Color.TRANSPARENT
        onMouseClicked: function(e) {
            if (sizeof mediaViews > 0) {
                var view = mediaViews[sizeof mediaViews - 1];
                closeView(view);
            }
        }
    }

    override function create() {
        Deck {
            content: bind [
                backgroundRectangle,
                mediaViews
            ]
        }
    }
}
