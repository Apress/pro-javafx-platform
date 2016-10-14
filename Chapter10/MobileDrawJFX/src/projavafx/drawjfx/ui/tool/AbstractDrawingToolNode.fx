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
 * AbstractDrawingToolNode.fx - The abstract base class for all drawing tools
 * in this program.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.drawjfx.ui.tool;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.input.MouseEvent;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Paint;
import javafx.scene.paint.Stop;
import projavafx.drawjfx.model.DrawJFXModel;

/**
 * The background of the button when not selected or hovering
 */
def BUTTON_NORMAL_PAINT: Paint = Color.rgb(226, 222, 197);

/**
 * The background of the button when hovering
 */
def BUTTON_HOVER_PAINT: Paint = LinearGradient {
    startX: 0.0,
    startY: 0.0,
    endX: 0.0,
    endY: 1.0
    stops: [
        Stop {
            offset: 0.0
            //color: Color.rgb(204, 204, 204)
            color: Color.rgb(205, 198, 152)
        },
        Stop {
            offset: 0.5
            //color: Color.rgb(153, 153, 153)
            color: Color.rgb(226, 222, 197)
        }
        Stop {
            offset: 1.0
            //color: Color.rgb(204, 204, 204)
            color: Color.rgb(205, 198, 152)
        }
    ]
};

/**
 * The background of the button when selected
 */
def BUTTON_SELECTED_PAINT: Paint = Color.rgb(205, 198, 152);

/**
 * The super class for all tools in the drawing tool box.
 */
public class AbstractDrawingToolNode extends CustomNode {
    /**
     * The model for use by subclasses
     */
    protected var djfxModel = DrawJFXModel.getInstance();

    /**
     * Desired width of the tool
     */
    public var width: Number = 32;

    /**
     * Desired width of the tool
     */
    public var height: Number = 32;

    /**
     * The Node that appears on the face of this tool
     */
    public var toolFaceNode: Node;

    /**
     * An optional label for this tool
     */
    public var toolLabel: String;

    /**
     * Determines whether this button is selected
     */
    public var selected: Boolean;

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
            var rectRef: Rectangle
            content: bind [
                rectRef = Rectangle {
                    width: bind width
                    height: bind height
                    fill: bind if (selected) BUTTON_SELECTED_PAINT
                               else if (hover) BUTTON_HOVER_PAINT
                               else BUTTON_NORMAL_PAINT
                    onMouseReleased: function(me:MouseEvent):Void {
                        action();
                    }
                },
                toolFaceNode
            ]
        }
    }
}
