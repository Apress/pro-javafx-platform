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
 * ImageFileView.fx - A JavaFX Script example program that
 * demonstrates how to build a rich Media Explorer application
 * that leverages layouts and utilities from the JFXtras project.
 *
 * Developed 2009 by Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.mediaexplorer.view;

import javafx.scene.image.Image;
import javafx.scene.paint.Color;
import org.jfxtras.scene.image.ImageUtil;
import org.jfxtras.scene.image.ResizableImageView;
import org.jfxtras.scene.border.FrameBorder;
import org.jfxtras.scene.border.TitledBorder;
import org.jfxtras.scene.layout.GridLayoutInfo;
import org.jfxtras.scene.layout.LayoutConstants.*;
import projavafx.mediaexplorer.MediaViewer;

import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;

/**
 * @author Stephen Chin
 */
public class ImageFileView extends FileView {

    public-init var thumbnail:Image;

    public-init var mediaViewer:MediaViewer;

    var image = Image {
        width: fromNode.scene.width
        height: fromNode.scene.height
        preserveRatio: true
        backgroundLoading: true
        placeholder: thumbnail
        url: ImageUtil.getURL(file)
    }

    override var onClose = image.cancel;

    override var onMouseClicked = function(e) {
        mediaViewer.closeView(this);
    }

    override function create() {
        FrameBorder {
            id: "imageFrame"
            // workaround because nested css properties in controls is broken
            backgroundFill: Color.rgb(0, 0, 112, 0.125);
            node: TitledBorder {
                id: "imageTitle"
                text: file.getName()
                // workaround because nested css properties in controls is broken
                borderWidth: 16
                font: Font.font("Serif", FontWeight.BOLD, 12);
                lineColor: Color.TRANSPARENT
                node: ResizableImageView {
                    layoutInfo: GridLayoutInfo {
                        hgrow: NEVER
                        vgrow: NEVER
                    }
                    preserveRatio: true
                    smooth: true
                    image: bind image
                }
            }
        }
    }
}
