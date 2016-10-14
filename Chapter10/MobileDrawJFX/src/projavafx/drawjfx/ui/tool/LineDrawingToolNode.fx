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
 * LineDrawingToolNode.fx - A drawing tool that, when selected, indicates that
 * the user wants to draw a Line.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.drawjfx.ui.tool;

import javafx.scene.shape.Line;
import javafx.scene.paint.Color;
import projavafx.drawjfx.ui.ShapeProducer;

/**
 * A drawing tool that, when selected, indicates that the user wants to
 * draw a Line.
 */
public class LineDrawingToolNode extends AbstractDrawingToolNode {
    var shapeProducer = ShapeProducer {
        produceShape: function() {
            Line {}
        }
        sizeShape: function(shape, x, y) {
            var line = shape as Line;
            line.endX = x;
            line.endY = y;
        }
    }

    override var selected = bind djfxModel.currentShapeProducer == shapeProducer;

    override var action = function():Void {
        djfxModel.currentShapeProducer = shapeProducer;
    }

    /**
    * Type of shape that this tool node represents
     */
    init {
        toolFaceNode = Line {
            startX: 4
            startY: 4
            endX: 28
            endY: 28
            stroke: Color.BLACK
            strokeWidth: 2
        }
    }
}
