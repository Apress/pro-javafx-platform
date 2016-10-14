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
 * DrawJFXMain.fx - A JavaFX Script example program that demonstrates
 * how to develop node-based UIs in JavaFX by creating a graphics builder.
 * This main program expressed the UI, including the drawing area, tool box
 * and color pickers.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 *               and Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.drawjfx.ui;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.shape.Shape;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;
import projavafx.colorpicker.ui.ColorPickerSnowFlakeNode;
import projavafx.drawjfx.model.DrawJFXModel;
import projavafx.drawjfx.ui.tool.*;
import projavafx.drawjfx.ui.tool.jfxtras.*;

def djfxModel = DrawJFXModel.getInstance();

function createSeparator() {
    Rectangle {
        width: 32
        height: 3
        fill: Color.WHITE
    }
}

var fillColorPicker = ColorPickerSnowFlakeNode {
    translateX: 100
    translateY: 10
    title: "Fill Color"
    visible: bind djfxModel.fillColorPickerVisible with inverse
    originalColor: bind djfxModel.currentFill
    onClose: function(color:Color) {
        if (djfxModel.currentSelectedNode != null) {
            (djfxModel.currentSelectedNode as Shape).fill = color;
        } else {
            djfxModel.currentFill = color;
        }
    }
}

var strokeColorPicker = ColorPickerSnowFlakeNode {
    translateX: 150
    translateY: 10
    title: "Stroke Color"
    visible: bind djfxModel.strokeColorPickerVisible with inverse
    originalColor: bind djfxModel.currentStroke
    onClose: function(color:Color) {
        if (djfxModel.currentSelectedNode != null) {
            (djfxModel.currentSelectedNode as Shape).stroke = color;
        } else {
            djfxModel.currentStroke = color;
        }
    }
}

var firstTool:AbstractDrawingToolNode;

Stage {
    title: "DrawJFXtras"
    resizable: false
    scene: Scene {
        var drawingAreaNode:DrawingAreaNode;
        content: [
            drawingAreaNode = DrawingAreaNode {
                width: 600
                height: 495
            },
            fillColorPicker,
            strokeColorPicker,
            // The drawing tool box
            VBox {
                spacing: 0
                translateX: 600
                content: [
                    DocumentDrawingToolNode {drawingAreaNode: drawingAreaNode},
                    createSeparator(),
                    firstTool = CircleDrawingToolNode {filled: false},
                    CircleDrawingToolNode {filled: true},
                    RectangleDrawingToolNode {filled: false},
                    RectangleDrawingToolNode {filled: true},
                    LineDrawingToolNode {},
                    createSeparator(),
                    PaintDrawingToolNode {fill: true},
                    PaintDrawingToolNode {fill: false},
                    StrokeWidthDrawingToolNode {},
                    createSeparator(),
                    DropShadowDrawingToolNode {},
                    ReflectionDrawingToolNode {},
                    createSeparator(),
                    ScaleDrawingToolNode {plusDirection: true},
                    ScaleDrawingToolNode {plusDirection: false},
                    RotateDrawingToolNode {plusDirection: true},
                    RotateDrawingToolNode {plusDirection: false}
                ]
            }
            // Shape text
            Text {
                content: "Extra Shapes:"
                textOrigin: TextOrigin.TOP
                translateX: 635
                translateY: 2
                font: Font.font(null, 9)
            }
            // Second row of tools
            VBox {
                spacing: 0
                translateX: 635
                translateY: 12
                content: [
                    AlmondDrawingToolNode {filled: false}
                    ArrowDrawingToolNode {filled: false}
                    AsteriskDrawingToolNode {filled: false}
                    AstroidDrawingToolNode {filled: false}
                    BalloonDrawingToolNode {filled: false}
                    CrossDrawingToolNode {filled: false}
                    DonutDrawingToolNode {filled: false}
                    LauburuDrawingToolNode {filled: false}
                    MultiRoundRectangleDrawingToolNode {filled: false}
                    RaysDrawingToolNode {filled: false}
                    RegularPolygonDrawingToolNode {filled: false}
                    ReuleauxTriangleDrawingToolNode {filled: false}
                    RoundPinDrawingToolNode {filled: false}
                    Star2DrawingToolNode {filled: false}
                    TriangleDrawingToolNode {filled: false}
                ]
            }
            // Third row of tools
            VBox {
                spacing: 0
                translateX: 667
                translateY: 12
                content: [
                    AlmondDrawingToolNode {filled: true}
                    ArrowDrawingToolNode {filled: true}
                    AsteriskDrawingToolNode {filled: true}
                    AstroidDrawingToolNode {filled: true}
                    BalloonDrawingToolNode {filled: true}
                    CrossDrawingToolNode {filled: true}
                    DonutDrawingToolNode {filled: true}
                    LauburuDrawingToolNode {filled: true}
                    MultiRoundRectangleDrawingToolNode {filled: true}
                    RaysDrawingToolNode {filled: true}
                    RegularPolygonDrawingToolNode {filled: true}
                    ReuleauxTriangleDrawingToolNode {filled: true}
                    RoundPinDrawingToolNode {filled: true}
                    Star2DrawingToolNode {filled: true}
                    TriangleDrawingToolNode {filled: true}
                ]
            }
        ]
    }
}

// Click the circle tool so it is highlighted on startup
firstTool.action();