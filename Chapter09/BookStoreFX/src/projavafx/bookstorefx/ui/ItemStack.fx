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

import java.lang.Math;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.transform.Translate;
import projavafx.bookstorefx.model.Item;
import projavafx.bookstorefx.model.ImageCache;
import projavafx.bookstorefx.ui.ItemSummary;

/**
 * @author Dean Iverson
 */
public class ItemStack extends CustomNode {
    public-init var imageCache: ImageCache;

    public var x = 0.0;
    public var y = 0.0;

    public var stackItemCount = 0;
    public var stackItemHeight = 0;

    public var items: Item[] on replace {
        updateDisplayList();
    }

    public function up() {
        if (displayIndex >= stackItemCount) {
            displayIndex -= stackItemCount;
        }
    }

    public function down() {
        if (displayIndex + stackItemCount < sizeof items) {
            displayIndex += stackItemCount;
        }
    }

    override function create() {
        var bookStack: Group = Group {
            content: [
                bookSummaries
            ]
        }
    }

    var displayIndex = 0 on replace {
        updateDisplayList();
    }

    var bookSummaries = bind for (i in [1..stackItemCount]) {
        ItemSummary {
            transforms: Translate {
                x: bind x
                y: bind y + i * stackItemHeight
            }
            imageCache: imageCache
            visible: false
        }
    } on replace {
        updateDisplayList();
    }

    function updateDisplayList() {
        var offsetIndex = Math.min( sizeof items - displayIndex, sizeof bookSummaries );
        for (i in [0..<sizeof bookSummaries]) {
            if (i < offsetIndex) {
                bookSummaries[i].item = items[
                displayIndex + i];
                bookSummaries[i].visible = true;
            } else {
                bookSummaries[i].visible = false;
            }
        }
    }
}
