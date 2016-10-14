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
 * DropShadowDrawingToolNode.fx - A drawing tool that, when selected, indicates that
 * the user wants to apply a drop shadow effect to the current shape.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.drawjfx.ui.tool;

import javafx.scene.effect.DropShadow;
import javafx.scene.shape.Circle;
import javafx.scene.paint.Color;

/**
 * A drawing tool that, when selected, indicates that
 * the user wants to apply a drop shadow effect to the current shape.
 */
public class DropShadowDrawingToolNode extends AbstractDrawingToolNode {

    override var selected = bind if (djfxModel.currentSelectedNode != null) {
        djfxModel.currentSelectedNode.effect instanceof DropShadow
    } else {
        djfxModel.currentEffect instanceof DropShadow
    }

    override var action = function():Void {
        if (djfxModel.currentSelectedNode != null) {
            if (djfxModel.currentSelectedNode.effect instanceof DropShadow) {
                djfxModel.currentSelectedNode.effect = null;
            } else {
                djfxModel.currentSelectedNode.effect = DropShadow {
                    offsetX: 4
                    offsetY: 4
                }
            }
        } else {
            if (djfxModel.currentEffect instanceof DropShadow) {
                djfxModel.currentEffect = null;
            } else {
                djfxModel.currentEffect = DropShadow {
                    offsetX: 4
                    offsetY: 4
                }
            }
        }
    }

    /**
     * Draw a circle with a drop shadow on the tool face
     */
    init {
        toolFaceNode = Circle {
            centerX: 14
            centerY: 12
            radius: 4
            fill: Color.BLACK
            effect: DropShadow {
                offsetX: 2
                offsetY: 2
            }
        }
    }
}
