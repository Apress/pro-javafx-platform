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
 * MediaGrid.fx - A JavaFX Script example program that
 * demonstrates how to build a rich Media Explorer application
 * that leverages layouts and utilities from the JFXtras project.
 *
 * Developed 2009 by Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.mediaexplorer;

import java.io.File;
import javafx.util.Math;
import org.jfxtras.scene.ResizableCustomNode;
import org.jfxtras.scene.image.ImageUtil;
import org.jfxtras.scene.layout.Grid;
import org.jfxtras.scene.layout.Row;
import org.jfxtras.util.SequenceUtil;
import projavafx.mediaexplorer.thumbnail.ImageThumbnail;
import projavafx.mediaexplorer.thumbnail.MediaThumbnail;
import projavafx.mediaexplorer.thumbnail.Thumbnail;

/**
 * @author Stephen Chin
 */
public class MediaGrid extends ResizableCustomNode {

    public var mediaFiles:File[];

    public-init var mediaViewer:MediaViewer;

    var rows:Row[];

    var thumbnailsPerSide:Integer;

    function stop(thumbnails:Thumbnail[]) {
        for (thumbnail in thumbnails) {
            thumbnail.stop();
        }
    }

    def thumbnails = bind for (mediaFile in mediaFiles) createThumbnail(mediaFile)
                     on replace oldThumbnails[a..b]=newThumbnails {
        stop(oldThumbnails[a..b]);
        thumbnailsPerSide = Math.ceil(Math.sqrt(thumbnails.size())).intValue();
        rows = for (i in [0..thumbnailsPerSide - 1]) Row {
            cells: for (j in [0..thumbnailsPerSide - 1]) {
                thumbnails[i * thumbnailsPerSide + j]
            }
        }
    }

    function createThumbnail(mediaFile:File) {
        if (ImageUtil.imageTypeSupported(mediaFile.getName())) {
            ImageThumbnail {mediaFile: mediaFile, mediaViewer: mediaViewer}
        } else {
            MediaThumbnail {mediaFile: mediaFile, mediaViewer: mediaViewer}
        }
    }

    public-read var progress =
      bind SequenceUtil.avg(for (thumbnail in thumbnails) thumbnail.progress);

    override function create() {
        Grid {
            var gap = bind if (thumbnailsPerSide == 0) 0
                           else height / thumbnailsPerSide * 0.15;
            border: bind gap
            vgap: bind gap
            hgap: bind gap
            rows: bind rows
        }
    }
}
