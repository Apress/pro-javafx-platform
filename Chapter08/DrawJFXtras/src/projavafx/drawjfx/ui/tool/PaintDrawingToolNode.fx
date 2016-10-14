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
 * PaintDrawingToolNode.fx - A drawing tool that, when selected, indicates that
 * the user wants to select a Paint object (Color is implemented so far).
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.drawjfx.ui.tool;

import javafx.scene.layout.VBox;
import javafx.scene.shape.Rectangle;
import javafx.scene.shape.Shape;
import javafx.scene.text.*;

/**
 * A drawing tool that, when selected, indicates that
 * the user wants to select a Paint object (Color or gradient).
 */
public class PaintDrawingToolNode extends AbstractDrawingToolNode {
    /**
     * Whether this tool is used to set the shape's fill (true) or
     * stroke (false) paint.
     */
    public var fill: Boolean;

    override var toolLabel = bind if (fill) then "fill" else "stroke";

    /**
    * Type of paint that this tool node represents
     */
    public var paint = bind if (fill) {
        if (djfxModel.currentSelectedNode != null) {
            (djfxModel.currentSelectedNode as Shape).fill
        } else {
            djfxModel.currentFill
        }
    } else {
        if (djfxModel.currentSelectedNode != null) {
            (djfxModel.currentSelectedNode as Shape).stroke
        } else {
            djfxModel.currentStroke
        }
    } on replace {
        toolFaceNode = VBox {
            translateX: 4
            translateY: 2
            spacing: 2
            content: [
                Text {
                    content: bind toolLabel
                    textOrigin: TextOrigin.TOP
                    font: Font.font("Sans serif", 9)
                },
                Rectangle {
                    width: 24
                    height: 14
                    fill: bind paint
                }
            ]
        }
    }

    override var action = function():Void {
        if (fill) {
            djfxModel.fillColorPickerVisible = true;
        } else {
            djfxModel.strokeColorPickerVisible = true;
        }
    }
}
