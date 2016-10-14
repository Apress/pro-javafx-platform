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
 * ArrowDrawingToolNode.fx - A drawing tool that, when selected, indicates that
 * the user wants to draw an Arrow.
 *
 * Developed 2009 by Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.drawjfx.ui.tool.jfxtras;

import javafx.scene.paint.Color;
import projavafx.drawjfx.ui.ShapeProducer;
import projavafx.drawjfx.ui.tool.AbstractFillableDrawingToolNode;
import org.jfxtras.scene.shape.Arrow;

/**
 * A drawing tool that, when selected, indicates that the user wants to
 * draw an Arrow.
 */
public class ArrowDrawingToolNode extends AbstractFillableDrawingToolNode {

    override var shapeProducer = ShapeProducer {
        produceShape: function() {
            Arrow {width: 0, height: 0}
        }
        sizeShape: function(shape, x, y) {
            var arrow = shape as Arrow;
            arrow.width = x;
            arrow.height = y;
        }
    }

    init {
        toolFaceNode = Arrow {
            x: 3
            y: 5
            width: 26
            height: 22
            fill: bind if (filled) Color.BLACK else Color.TRANSPARENT
            stroke: Color.BLACK
        }
    }
}
