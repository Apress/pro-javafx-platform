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
 * Main.fx - A JavaFX Script example program that
 * demonstrates how to build a rich Media Explorer application
 * that leverages layouts and utilities from the JFXtras project.
 *
 * Developed 2009 by Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.mediaexplorer;

import javafx.scene.control.ProgressBar;
import javafx.scene.effect.Reflection;
import javafx.scene.paint.*;
import javafx.scene.text.*;
import javafx.stage.Stage;
import org.jfxtras.scene.ResizableScene;
import org.jfxtras.scene.layout.Grid;
import org.jfxtras.scene.layout.GridLayoutInfo;
import org.jfxtras.scene.layout.LayoutConstants.*;
import org.jfxtras.scene.shape.ResizableRectangle;
import projavafx.mediaexplorer.view.FileView;

/**
 * @author Stephen Chin
 */
var text = Text {
    content: "Media Explorer"
    font: Font.font("Serif", 48);
}
var navigator = DirectoryNavigator {
    layoutInfo: GridLayoutInfo {
        width: 300
        hgrow: NEVER
    }
}
var mediaViewer = MediaViewer {}
var mediaGrid = MediaGrid {
    mediaFiles: bind navigator.mediaFiles
    mediaViewer: mediaViewer;
}
// workaround for defect RT-4700
var progress = bind ProgressBar.computeProgress(100, if (Float.isNaN(mediaGrid.progress)) 0  else mediaGrid.progress);
var progressBar = ProgressBar {
    progress: bind progress
}

Stage {
    title: "Media Explorer"
// workaround for RT-4833
    scene: FileView.sceneRef = ResizableScene {
        width: 800
        height: 500
        stylesheets: "{__DIR__}Border.css"
        content: [
            ResizableRectangle {
                cache: true
                fill: RadialGradient {
                    radius: 1.4
                    stops: [
                        Stop {offset: 0.0, color: Color.web("#3582ca")},
                        Stop {offset: 0.45, color: Color.WHITE},
                        Stop {offset: 0.452, color: Color.web("#8a9ed9")},
                        Stop {offset: 0.48, color: Color.web("#000f39")},
                        Stop {offset: 0.62, color: Color.web("#6d88c4")},
                        Stop {offset: 1.0, color: Color.WHITE}
                    ]
                }
            },
            Grid {
                effect: Reflection {}
                border: 20
                vgap: 12
                hgap: 12
                rows: bind [
                    row([text, progressBar]),
                    row([navigator, mediaGrid])
                ]
            },
            mediaViewer
        ]
    }
}
