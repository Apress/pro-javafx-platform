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
 * CongressMemberNodeFactory.fx
 *
 * Created on Mar 4, 2009, 8:30:42 AM
 */

package projavafx.whoismyrep.ui;

import javafx.scene.Node;
import javafx.scene.effect.DropShadow;
import javafx.scene.paint.Color;
import org.jfxtras.scene.layout.MigLayout;
import org.jfxtras.scene.layout.MigLayout.*;
import org.jfxtras.scene.shape.ResizableRectangle;
import projavafx.whoismyrep.model.Representative;
import projavafx.whoismyrep.model.Senator;


import javafx.scene.text.Text;

/**
 * @author Dean Iverson
 */
public function create( member:Senator, constraints:String ):Node {
  var district = if(member instanceof Representative) {
    "District {(member as Representative).district}"
  } else {
      ""
  }

  var nameStr = "{member.honorific} {member.name}";
  var descStr = "{member.party}-{member.state} {district}";

  MigLayout {
    constraints: "wrap"
    columns: "[]unrel[]"
    content: [
      ResizableRectangle {
        arcWidth: 20
        arcHeight: 20
        styleClass: member.party
        layoutInfo: nodeConstraints( "pos 0 0 container.x2 container.y2" )
      }
      text( nameStr, "name", "span, gapbottom unrel" ),
      text( descStr, "label", "span" ),
      text( "Phone:", "label", "" ),   text( member.phone, "info", "" ),
      text( "Office:", "label", "" ),  text( member.office, "info", "" ),
      text( "Website:", "label", "" ), text( member.website, "info", "" ),
      if (member.contact.length() > 0 ) {
        [text( "Contact:", "label", "" ), text( member.contact, "info", "" )]
      } else {
        null
      }
    ]
    layoutInfo: nodeConstraints( constraints )
    effect: DropShadow {
      offsetX: 4
      offsetY: 4
    }
  }
}

def MAX_TEXT_WIDTH = 280;

function text( content:String, style:String, constraints:String ) {
  Text {
    content: content
    wrappingWidth: MAX_TEXT_WIDTH
    styleClass: style
    layoutInfo: nodeConstraints( constraints )
  }
}
