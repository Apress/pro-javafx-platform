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
 */
package projavafx.bookstorefx.ui;

import javafx.scene.control.TextBox;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.layout.HBox;
import javafx.scene.shape.Circle;
import javafx.scene.shape.Line;
import javafx.scene.shape.Rectangle;

/**
 * @author Dean Iverson
 */
public class SearchBox extends CustomNode {
    public var width = 100.0;
    public var height = 20.0;
    public var onSearch: function( keywords:String );

    override function create() {
        Group {
            content: [
                Rectangle {
                    id: "searchBackground"
                    smooth: true
                    width: bind width
                    height: bind height
                    arcWidth: bind height
                    arcHeight: bind height
                },
                HBox {
                    var textBox: TextBox;
                    spacing: MAGNIFIER_PADDING + 4
                    content: [
                        magnifyingGlass(),
                        textBox = TextBox {
                            id: "searchTextBox"
                            translateY: bind (height - textBox.height) / 2
                            width: bind width - (MAGNIFIER_SIZE+MAGNIFIER_PADDING) * 2
                            height: bind height - 10
                            action: function() {
                                onSearch( textBox.text );
                            }
                        }
                    ]
                }
            ]
        }
    }

    def MAGNIFIER_SIZE = 15;
    def MAGNIFIER_PADDING = 5;

    function magnifyingGlass() {
        Group {
            translateX: MAGNIFIER_PADDING
            translateY: (height - MAGNIFIER_SIZE) / 2
            content: [
                Circle {
                    id: "magnifierLense"
                    centerX: MAGNIFIER_SIZE / 3
                    centerY: MAGNIFIER_SIZE / 3
                    radius: MAGNIFIER_SIZE / 3
                },
                Line {
                    id: "magnifierHandle"
                    startX: MAGNIFIER_SIZE * 2 / 3
                    startY: MAGNIFIER_SIZE * 2 / 3
                    endX: MAGNIFIER_SIZE
                    endY: MAGNIFIER_SIZE
                }
            ]
        }
    }
}
