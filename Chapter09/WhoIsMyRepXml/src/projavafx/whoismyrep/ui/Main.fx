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
 * Main.fx
 *
 * Created on Mar 3, 2009, 5:29:52 PM
 */

package projavafx.whoismyrep.ui;

import javafx.stage.Stage;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;
import org.jfxtras.scene.layout.MigLayout;
import org.jfxtras.scene.layout.MigLayout.*;
import projavafx.whoismyrep.model.ApplicationModel;
import projavafx.whoismyrep.ui.ZipCodeRow;
import org.jfxtras.scene.ResizableScene;

/**
 * @author dean
 */
def model = ApplicationModel {}
var sceneRef:ResizableScene;

Stage {
  title: "Who Is My Representative?"
  scene: sceneRef = ResizableScene {
    width: 800
    height: 500
    stylesheets: "{__DIR__}styles.css"
    content: [
      MigLayout {
        constraints: "fill"
        content: [
          ZipCodeRow {
            zipcode: bind model.zipcode with inverse
            layoutInfo: nodeConstraints( "north")
          }
          MigLayout {
            constraints: "fill, wrap, gap 1cm"
            columns: "[][]"
            content: bind [
              for (senator in model.senators) {
                CongressMemberNodeFactory.create( senator, "sg, grow" )
              }
              for (rep in model.representatives) {
                CongressMemberNodeFactory.create( rep, "sg, grow" )
              }
              Text {
                content: bind model.message
                visible: bind model.message.length() > 0
                textOrigin: TextOrigin.TOP
                layoutInfo: nodeConstraints( "span, ax center, ay top" )
              }
            ]
            layoutInfo: nodeConstraints( "grow" )
          }
        ]
      }
    ]
  }
}

def senators = bind model.senators on replace {
  // The scene is being updated, reapply stylesheets
  delete sceneRef.stylesheets;
  sceneRef.stylesheets = "{__DIR__}styles.css";
}

