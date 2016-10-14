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

import javafx.animation.Interpolator;
import javafx.animation.Timeline;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.ProgressIndicator;
import javafx.scene.control.RadioButton;
import javafx.scene.layout.Flow;
import javafx.stage.Stage;

var progress = 0.0;
var t = Timeline {
  keyFrames: [
    at(0s) { progress => 0.0 }
    at(3s) { progress => 1.0 tween Interpolator.EASEBOTH }
  ]
}

/**
 * @author dean
 */
Stage {
    var sceneRef:Scene;

    title: "Control Styling"
    width: 400
    height: 400
    scene: sceneRef = Scene {
        stylesheets: "{__DIR__}controlStyles.css"
        content: [
            Flow {
                vgap: 10
                hgap: 10
                width: bind sceneRef.width
                content: [
                    for (i in [1..4]) {
                        Label {
                            text: "Label {i}"
                            id: "label{i}"
                            styleClass: "labels"
                        }
                    }
                    for (i in [1..3]) {
                        Button {
                            text: "Button {i}"
                            id: "button{i}"
                            styleClass: "buttons"
                        }
                    }
                    for (i in [1..4]) {
                        CheckBox {
                            text: "Check Box {i}"
                            id: "check{i}"
                            styleClass: "checks"
                        }
                    }
                    for (i in [1..4]) {
                        RadioButton {
                            text: "Radio Button {i}"
                            id: "radio{i}"
                            styleClass: "radios"
                        }
                    }
                    ProgressBar {
                      progress: -1
                      id: "progressBar"
                      styleClass: "progress"
                    }
                    ProgressIndicator {
                      progress: bind progress
                      id: "progressIndicator"
                      styleClass: "progress"
                    }
                ]
            }
        ]
    }
}

t.play();

