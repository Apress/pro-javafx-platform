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
 * MetronomePathTransitionMain.fx - A simple example of animation using the
 * PathTransition class.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.metronometransition.ui;

import javafx.animation.Interpolator;
import javafx.animation.Timeline;
import javafx.animation.transition.AnimationPath;
import javafx.animation.transition.OrientationType;
import javafx.animation.transition.PathTransition;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.shape.Ellipse;
import javafx.scene.shape.ArcTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

var ellipse:Ellipse;
var path:Path = Path {
  elements: [
    MoveTo {
      x: 100
      y: 50
    },
    ArcTo {
      x: 300
      y: 50
      radiusX: 350
      radiusY: 350
      sweepFlag: true
    }
  ]
}

var anim = PathTransition {
  duration: 1s
  node: bind ellipse
  path: AnimationPath.createFromPath(path)
  orientation: OrientationType.ORTHOGONAL_TO_TANGENT
  interpolator: Interpolator.LINEAR
  autoReverse: true
  repeatCount: Timeline.INDEFINITE
};

Stage {
  title: "Metronome using PathTransition"
  width: 400
  height: 500
  visible: true
  scene: Scene {
    content: [
      ellipse = Ellipse {
        centerX: 100
        centerY: 50
        radiusX: 4
        radiusY: 8
        fill: Color.BLUE
      },
      HBox {
        layoutX: 60
        layoutY: 420
        spacing: 10
        content: [
          Button {
            text: "Start"
            disable: bind anim.running
            action: function():Void {
              anim.playFromStart();
            }
          },
          Button {
            text: "Pause"
            disable: bind anim.paused or not anim.running
            action: function():Void {
              anim.pause();
            }
          },
          Button {
            text: "Resume"
            disable: bind not anim.paused
            action: function():Void {
              anim.play();
            }
          },
          Button {
            text: "Stop"
            disable: bind not anim.running
            action: function():Void {
              anim.stop();
            }
          }
        ]
      }
    ]
  }
}