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
 * DrawJFXModel.fx - The main model for the DrawJFX program
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.drawjfx.model;

import javafx.scene.Node;
import javafx.scene.effect.Effect;
import javafx.scene.paint.Color;
import projavafx.drawjfx.ui.ShapeProducer;

/**
 * Singleton model instance
 */
var modelInstance:DrawJFXModel;

/**
 * Retrieves singleton model instance, creating one if it doesn't exist
 */
public function getInstance():DrawJFXModel {
    if (modelInstance == null) {
        modelInstance = DrawJFXModel {}
    }
    return modelInstance;
}

/**
 * The main model for the DrawJFX program
 */
public class DrawJFXModel {
    /**
     * Reference to a drawn node selected by the mouse
     */
    public var currentSelectedNode:Node;

    /**
     * Type of shape currently selected
     */
    public var currentShapeProducer:ShapeProducer;

    /**
     * Current fill color
     */
    public var currentFill:Color = Color.BLUE;

    /**
     * Current stroke color
     */
    public var currentStroke:Color = Color.BLACK;

    /**
     * Current stroke width
     */
    public var currentStrokeWidth:Integer = 1;

    /**
     * Determines if current shape is filled
     */
    public var currentFilled:Boolean;

    /**
     * Currently selected Effect
     */
    public var currentEffect:Effect;

    /**
     * X position of the drag anchor
     */
    public var dragAnchorX:Number;

    /**
     * Y position of the drag anchor
     */
    public var dragAnchorY:Number;

    /**
     * X position of the drag position
     */
    public var dragPosX:Number;

    /**
     * X position of the drag position
     */
    public var dragPosY:Number;

    /**
     * Visibility of the fill color picker (set to true to show)
     */
    public var fillColorPickerVisible:Boolean;

    /**
     * Visibility of the stroke color picker (set to true to show)
     */
    public var strokeColorPickerVisible:Boolean;
}


