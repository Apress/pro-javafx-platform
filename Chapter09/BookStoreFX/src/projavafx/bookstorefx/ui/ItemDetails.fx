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

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;
import org.jfxtras.scene.layout.MigLayout;
import org.jfxtras.scene.layout.MigLayout.*;
import projavafx.bookstorefx.model.ImageCache;
import projavafx.bookstorefx.model.Item;
import projavafx.bookstorefx.ui.NodeFactory;

/**
 * @author Dean Iverson
 */

public class ItemDetails extends CustomNode {
    public var item: Item;
    public var imageCache: ImageCache;

    def MAX_IMAGE_WIDTH = 150;
    def MAX_IMAGE_HEIGHT = 200;
    def TITLE_WIDTH = 280;
    def TITLE_HEIGHT = 45;

    function createTextNode( text:String ):Text {
        Text {
            textOrigin: TextOrigin.TOP
            fill: Color.rgb(62,38,26)
            content: text
            font: Font.font("sans serif", FontWeight.BOLD, 18)
            wrappingWidth: 240
        }
    }

    var authorNodes: Text[] = bind [ createTextNode( "By:" ), createTextNode( item.creator ) ];
    var detailNodes = bind for (obj in item.details) {
        if (obj instanceof String) {
            createTextNode( obj as String )
        } else {
            null
        }
    }

    override function create() {
        Group {
            content: [
                NodeFactory.getItemDetailsBackground(),
                Group {
                    // Position of large detail area
                    translateX: 206
                    translateY: 441
                    content: bind [
                        Text {
                            translateX: 180
                            translateY: 34
                            content: bind item.title
                            font: Font.font("sans serif", 20)
                            fill: Color.rgb(221,199,175)
                            wrappingWidth: TITLE_WIDTH
                            textOrigin: TextOrigin.TOP
                            clip: Rectangle {
                                width: TITLE_WIDTH
                                height: TITLE_HEIGHT
                            }
                        },
                        Text {
                            translateX: 482
                            translateY: 41
                            textOrigin: TextOrigin.TOP
                            content: bind item.price
                            font: Font.font("sans serif", 30)
                            fill: Color.rgb(232,115,1)
                        },
                        ImageView {
                            translateX: 20
                            translateY: 20
                            image: bind imageCache.getImage( item.detailedImageURL, MAX_IMAGE_WIDTH, MAX_IMAGE_HEIGHT );
                        },
                        MigLayout {
                            translateX: 210
                            translateY: 100
                            width: 360
                            height: 300
                            constraints: "wrap"
                            columns: "[][]"
                            content: [
                                migNode( authorNodes[0], "top" ),
                                migNode( authorNodes[1], "top" ),
                                for (node in detailNodes) {
                                    migNode( node, "top" )
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    }

}
