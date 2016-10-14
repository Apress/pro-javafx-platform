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

package projavafx.styling;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.layout.Flow;
import javafx.scene.shape.Circle;
import javafx.scene.shape.Rectangle;
import org.jfxtras.scene.shape.Star2;

/**
 * @author Dean Iverson
 */
Stage {
    var sceneRef:Scene;
    title: "Shape Styling"
    scene: sceneRef = Scene {
        stylesheets: "{__DIR__}shapeStyles.css"
        width: 400
        height: 400
        content: [
            Flow {
                width: bind sceneRef.width
                hgap: 10
                vgap: 10
                content: [
                    for (i in [1..8]) {
                        Circle {
                          radius: 25
                          id: "circle{i}"
                          styleClass: "circles"
                        }
                    }
                    for (i in [1..8]) {
                        Rectangle {
                          width: 40
                          height: 40
                          id: "rect{i}"
                          styleClass: "rects"
                        }
                    }
                    for (i in [1..8]) {
                        Star2 {
                          innerRadius: 15
                          outerRadius: 30
                          id: "star{i}"
                          styleClass: "stars"
                        }
                    }
                ]
            }
        ]
    }
}