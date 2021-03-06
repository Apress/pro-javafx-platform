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
 * DocumentDrawingToolNode.fx - Drawing tools that, when selected, do operations
 * such as open file, create new document.  The only operation implemented is
 * create new document, which effectly just deletes all of the shapes
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.drawjfx.ui.tool;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.stage.Alert;
import projavafx.drawjfx.ui.DrawingAreaNode;

/**
 * Drawing tools that, when selected, do operations
 * such as open file, create new document.  The only operation implemented is
 * create new document, which effectly just deletes all of the shapes
 */
public class DocumentDrawingToolNode extends AbstractDrawingToolNode {
    public-init var drawingAreaNode:DrawingAreaNode;

    override var action = function():Void {
        var createNew = Alert.confirm("DrawFX - Confirm New Drawing",
                       "Are you sure you want to create a new drawing?");
        if (createNew) {
            drawingAreaNode.eraseDrawing();
        }
    }

    /**
     * Show a new document icon on the tool face
     */
    init { 
        toolFaceNode = ImageView {
            image: Image {
                url: "{__DIR__}image/new_drawing.png"
            }
        }
    }
}
