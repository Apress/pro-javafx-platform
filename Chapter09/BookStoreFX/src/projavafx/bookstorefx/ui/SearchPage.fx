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

import javafx.animation.Timeline;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import projavafx.bookstorefx.model.BookStoreModel;
import projavafx.bookstorefx.model.Item;
import projavafx.bookstorefx.ui.ItemCarousel;

/**
 * @author Dean Iverson
 */
public class SearchPage extends CustomNode {
    public-init var model: BookStoreModel;

    def MAX_LARGE_BOOK_WIDTH: Number = 160;
    var selectedItem: Item;
    var pageOpacity = 1.0;
    var searchOpacity = 0.0;
    var searchResults = bind model.searchResults on replace {
        searchOpacity = if (sizeof model.searchResults > 0) pageOpacity else 0.0;
    }

    public function pageInTransition():Timeline {
        Timeline {
            keyFrames: [
                at (0s) { pageOpacity => 0.0 },
                at (0.25s) { pageOpacity => 1.0 },
            ]
        }
    }

    public function pageOutTransition():Timeline {
        Timeline {
            keyFrames: [
                at (0s) { pageOpacity => 1.0 },
                at (0.25s) { pageOpacity => 0.0 },
            ]
        }
    }

    public override function create():Node {
        Group {
            opacity: bind pageOpacity
            content: [
                SearchBox {
                    translateX: 750
                    translateY: 120
                    width: 260
                    height: 36
                    onSearch: function( keywords:String ) {
                        model.keywords = keywords;
                    }
                },
                ItemCarousel {
                    imageCache: model.imageCache
                    items: bind model.searchResults
                    translateY: 180
                    opacity: bind searchOpacity
                    onShowDetails: function( item:Item ) {
                        selectedItem = item;
                    }
                },
                ItemDetails {
                    item: bind selectedItem
                    imageCache: bind model.imageCache;
                    opacity: bind searchOpacity
                }
            ]
        }
    }
}
