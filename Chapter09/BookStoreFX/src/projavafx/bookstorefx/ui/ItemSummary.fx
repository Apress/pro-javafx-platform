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

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;
import javafx.scene.Node;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;
import org.jfxtras.scene.layout.MigLayout;
import org.jfxtras.scene.layout.MigLayout.*;
import org.jfxtras.scene.shape.ResizableRectangle;
import org.jfxtras.scene.shape.Star2;
import projavafx.bookstorefx.model.ImageCache;
import projavafx.bookstorefx.model.Item;
import projavafx.bookstorefx.ui.NodeFactory;

/**
 * @author Dean Iverson
 */
package def WIDTH = 300;
package def HEIGHT = 130;

public class ItemSummary extends CustomNode {
  def TITLE_WIDTH: Number = 200;
  def TITLE_HEIGHT: Number = 30;

  public-init var imageCache: ImageCache;
  public var item: Item;
  public var onShowDetails: function( item:Item );

  var title = Text {
    content: bind item.title
    wrappingWidth: TITLE_WIDTH
    styleClass: "summaryTitle"
    textOrigin: TextOrigin.TOP
    clip: Rectangle {
      width: TITLE_WIDTH
      height: TITLE_HEIGHT
    }
  }

  var price = Text {
    content: bind item.price
    styleClass: "summaryPrice"
  }

  var thumbnail = ImageView {
    image: bind imageCache.getImage( item.imageURL );
  }

  var rating = HBox {
    content: bind for (i in [1..5]) {
      Star2 {
        outerRadius: 8;
        innerRadius: 5;
        styleClass: if( i <= item.rating ) "filledStar" else "emptyStar"
      }
    }
  }

  var background = ResizableRectangle {
    styleClass: "summaryBackground"
  }

  function detailsAction() {
    onShowDetails( item );
  }

  override function create():Node {
    NodeFactory.makeButton( thumbnail, detailsAction );
    Group {
      content: [
        MigLayout {
          width: WIDTH
          height: HEIGHT
          constraints: "fill, wrap"
          columns: "[80!]5mm[]"
          rows: "[30!][][][]"

          content: [
            migNode( thumbnail,  "spany, center"),
            migNode( title,      "w 200"),
            migNode( price,      ""),
            migNode( rating,     ""),
            migNode( NodeFactory.createDetailsButton(detailsAction), "" )
          ]
        }
      ]
    }
  }
}
