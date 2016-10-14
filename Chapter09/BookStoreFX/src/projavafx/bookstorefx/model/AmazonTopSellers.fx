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
 * AwsHttpRequest.fx
 *
 * Created on Feb 15, 2009, 2:45:28 PM
 */

package projavafx.bookstorefx.model;

import javafx.data.pull.Event;
import javafx.data.pull.PullParser;
import projavafx.bookstorefx.model.Category;
import projavafx.bookstorefx.model.Item;
import org.jfxtras.util.SequenceUtil;

/**
 * @author Dean Iverson
 */
public class AmazonTopSellers {
  def BROWSE_NODE_OPERATION = "BrowseNodeLookup";
  def BROWSE_NODE_RESPONSE_GROUP = "ResponseGroup=TopSellers";

  def ITEM_LOOKUP_OPERATION = "ItemLookup";
  def ITEM_LOOKUP_RESPONSE_GROUP = "ResponseGroup=Small,Images,Reviews,Offers";

  public-init var category = Category.BOOKS;
  public-init var onDone: function( :Item[] ):Void;

  var request: AmazonHttpRequest;

  postinit {
    request = AmazonHttpRequest {
      var asins: String[]

      operation: BROWSE_NODE_OPERATION
      extraParams: composeBrowseNodeParams()

      onInput: function(is: java.io.InputStream) {
        try {
          PullParser {
            input: is
            documentType: PullParser.XML;
            onEvent: function (e: Event) {
              if (e.type == PullParser.END_ELEMENT and e.qname.name == "ASIN" ) {
                insert e.text into asins;
              }
            }
          }.parse();
        } finally {
          is.close();
        }
      }

      onDone: function() {
        AmazonHttpRequest {
          var items: Item[];

          operation: ITEM_LOOKUP_OPERATION
          extraParams: composeItemLookupParams(asins)
          onInput: function(is: java.io.InputStream) {
            var ip = ItemParser {
              input: is
            }
            items = ip.parse();
          }

          onDone: function() {
            onDone( items );
          }
        }.start();
      }
    }
  }

  public function start() {
    request.start();
  }

  function composeBrowseNodeParams():String {
    "BrowseNodeId={category.getBrowseNodeId()}&{BROWSE_NODE_RESPONSE_GROUP}";
  }

  function composeItemLookupParams( asins:String[] ):String {
    "ItemId={SequenceUtil.join( asins, "," )}&{ITEM_LOOKUP_RESPONSE_GROUP}";
  }
}

