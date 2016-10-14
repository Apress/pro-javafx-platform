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
 * StrokeWidthDrawingToolNode.fx - A drawing tool that, when selected, enables
 * the user to select the strokeWidth for a shape
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.drawjfx.ui.tool;

import javafx.scene.layout.VBox;
import javafx.scene.shape.Line;
import javafx.scene.shape.Shape;
import javafx.scene.paint.Color;
import javafx.scene.text.*;

/**
 * A drawing tool that, when selected, indicates that
 * the user wants to select an effect.
 */
public class StrokeWidthDrawingToolNode extends AbstractDrawingToolNode {
    def MAX_STROKE_WIDTH: Integer = 5;

    override var toolLabel = "width";

    /**
     * Current strokeWidth that this tool represents
     */
    public var strokeWidthVal:Number = bind if (djfxModel.currentSelectedNode != null) {
        (djfxModel.currentSelectedNode as Shape).strokeWidth
    }
    else {
        djfxModel.currentStrokeWidth
    } on replace {
        toolFaceNode = VBox {
            layoutX: 4
            layoutY: 2
            spacing: 6
            content: [
                Text {
                    content: bind toolLabel
                    textOrigin: TextOrigin.TOP
                    font: Font.font("Sans serif", 9)
                },
                Line {
                    startX: 4
                    startY: 0
                    endX: 20
                    endY: 0
                    stroke: Color.BLACK
                    strokeWidth: bind strokeWidthVal
                }
            ]
        };
    }

    override var action = function():Void {
        if (djfxModel.currentSelectedNode != null) {
            (djfxModel.currentSelectedNode as Shape).strokeWidth =
                ((++( djfxModel.currentSelectedNode as Shape)
                .strokeWidth - 1) mod MAX_STROKE_WIDTH) + 1;

        }
        else {
            djfxModel.currentStrokeWidth =
                ((++djfxModel .currentStrokeWidth - 1) mod
                MAX_STROKE_WIDTH) + 1;
        }
    }

}
