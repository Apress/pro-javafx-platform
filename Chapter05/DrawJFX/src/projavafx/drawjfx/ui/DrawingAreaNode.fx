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
 * DrawingAreaNode.fx - The active drawing area for the application.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.drawjfx.ui;

import javafx.scene.CustomNode;
import javafx.scene.Cursor;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.shape.Shape;
import projavafx.drawjfx.ui.tool.AbstractDrawingToolNode;
import projavafx.drawjfx.model.DrawJFXModel;

/**
 * A drawing tool that, when selected, indicates that the user wants to
 * draw a Circle.
 */
public class DrawingAreaNode extends CustomNode {

    /**
     * A reference to the main model
     */
    var djfxModel = DrawJFXModel.getInstance();

    /**
     * The desired width of this node
     */
    public var width:Number;

    /**
     * The desired height of this node
     */
    public var height:Number;

    /**
     * A sequence containing the ButtonNode instances
     */
    public var drawingToolNodes:AbstractDrawingToolNode[];

    /**
     * A reference to the root node of the scenegraph
     */
    var drawNodeRef:Group = Group {}

    /**
     * A reference to the current shape
     */
    var shape:Shape;

    /**
     * Erase the contents of the drawing
     */
    public function eraseDrawing():Void {
        drawNodeRef.content = null;
        djfxModel.currentSelectedNode = null;
    }

    var selection:Rectangle = bind createSelection(djfxModel.currentSelectedNode);

    function createSelection(s:Node) {
        var selected = s;
        var result = if (selected == null) {
            null
        } else {
            Rectangle {
                x: bind selected.boundsInParent.minX
                y: bind selected.boundsInParent.minY
                width: bind selected.boundsInParent.width
                height: bind selected.boundsInParent.height
                fill: null
                stroke: Color.BLUEVIOLET
                strokeDashArray: [5, 5]
            }
        }
        return result;
    }

    /**
     * Create the Node
     */
    override public function create():Node {
        Group {
            content: bind [
                Rectangle {
                    cursor: Cursor.CROSSHAIR
                    width: bind width
                    height: bind height
                    fill: Color.WHITE
                },
                drawNodeRef,
                selection
            ]
        }
    }

    override var onMousePressed = function(me:MouseEvent) {
        djfxModel.dragAnchorX = me.x;
        djfxModel.dragAnchorY = me.y;
        shape = djfxModel.currentShapeProducer.produceShape();
        initializeShape(shape, me.x, me.y);
        insert shape into drawNodeRef.content;
    }

    override var onMouseDragged = function(me:MouseEvent) {
        // Identify this Node as one that has been drawn (dragged)
        shape.id = "id:{sizeof drawNodeRef.content - 1}";

        djfxModel.dragPosX = me.x;
        djfxModel.dragPosY = me.y;
        var x = djfxModel.dragPosX - djfxModel.dragAnchorX;
        var y = djfxModel.dragPosY - djfxModel.dragAnchorY;
        djfxModel.currentShapeProducer.sizeShape(shape, x, y);
    }

    override var onMouseReleased = function(me:MouseEvent) {
        // If the user clicked on the drawing area, but didn't drag to
        // give the shape a size, then remove it from the content sequence
        if (shape.id == "") {
            delete shape from drawNodeRef.content;
            djfxModel.currentSelectedNode = null;
        } else {
            djfxModel.currentSelectedNode = shape;
        }
    }

    override var onKeyPressed = function(ke:KeyEvent):Void {
        if (ke.code == KeyCode.VK_DELETE) {
            delete djfxModel.currentSelectedNode from drawNodeRef.content;
        }
    }

    function initializeShape(shape:Shape, x:Number, y:Number) {
        shape.blocksMouse = true;
        shape.cursor = Cursor.DEFAULT;
        shape.stroke = djfxModel.currentStroke;
        shape.strokeWidth = djfxModel.currentStrokeWidth;
        shape.fill = if (djfxModel.currentFilled) {
            djfxModel.currentFill
        } else {
            Color.TRANSPARENT
        }
        shape.layoutX = x;
        shape.layoutY = y;
        shape.effect = djfxModel.currentEffect;
        var dragStartX:Number;
        var dragStartY:Number;
        shape.onMousePressed = function(me:MouseEvent) {
            djfxModel.currentSelectedNode = shape;
            shape.toFront();
            shape.requestFocus();
            dragStartX = shape.layoutX;
            dragStartY = shape.layoutY;
        }
        shape.onMouseDragged = function(me:MouseEvent) {
            shape.layoutX = dragStartX + me.dragX;
            shape.layoutY = dragStartY + me.dragY;
        }
        shape.onKeyPressed = function(ke:KeyEvent):Void {
            if (ke.code == KeyCode.VK_DELETE) {
                delete djfxModel.currentSelectedNode from drawNodeRef.content;
                djfxModel.currentSelectedNode = null;
            }
        }
    }
}