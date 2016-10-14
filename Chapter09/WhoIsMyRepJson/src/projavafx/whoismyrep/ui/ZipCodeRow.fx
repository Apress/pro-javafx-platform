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
 * ZipCodeRow.fx
 *
 * Created on Mar 4, 2009, 8:57:22 AM
 */

package projavafx.whoismyrep.ui;

import javafx.scene.control.TextBox;
import javafx.scene.Group;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;
import org.jfxtras.scene.layout.ResizableHBox;
import org.jfxtras.scene.ResizableCustomNode;
import org.jfxtras.scene.shape.Arrow;

/**
 * @author Dean Iverson
 */
public class ZipCodeRow extends ResizableCustomNode {
  public var zipcode: String;

  var textBox: TextBox;
  override function create() {
    ResizableHBox {
      spacing: 5
      content: [
        arrowGroup( "Type Zip Code", 0, "darrow"),
        textBox = TextBox {
          action: function() {
            if( textBox.text != null )
              zipcode = textBox.text;
          }
        },
        arrowGroup( "Press Enter", 180, "rarrow")
      ]
    }
  }

  function arrowGroup( text:String, angle:Number, id:String ) {
    Group {
      var a: Arrow;
      var t: Text;

      content: [
        a = Arrow {
          id: id
          width: 280
          height: 40
          rise: 0.5
          depth: 0.9
          rotate: angle
        },
        t = Text {
          content: text
          textOrigin: TextOrigin.TOP
          translateY: bind (a.height - t.layoutBounds.height) / 2 - t.layoutBounds.minY
          translateX: bind {
            if (angle == 0) {
                (a.width * 0.9) - t.layoutBounds.width
            } else {
                (a.width * 0.1)
            }
          }
        }
      ]
    }
  }
}
