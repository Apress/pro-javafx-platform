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

import projavafx.bookstorefx.model.Category;
import projavafx.bookstorefx.model.SortBy;

/**
 * @author Dean Iverson
 */
public class AmazonItemSearch {
  def OPERATION = "ItemSearch";
  def RESPONSE_GROUP = "ResponseGroup=Small,Images,Reviews,Offers";

  public-init var maxResults = 10;
  public-init var keywords = "JavaFX";
  public-init var sortBy = SortBy.RELEVANCE;
  public-init var category = Category.BOOKS;
  public-init var onResultsAvailable: function( :Item[] ):Void;
  public-init var onDone: function():Void;

  public-read var canceled = false;

  var items: Item[];
  var itemCount = 0;
  var request: AmazonHttpRequest;
  var requestCount = 0;
  var resultsAvailable: Integer;

  postinit {
    createRequest();
  }

  public function start() {
    request.start();
  }

  public function stop() {
    canceled = true;
    request.stop();
  }

  function createRequest():Void {
    requestCount++;
    request = AmazonHttpRequest {
      operation: OPERATION
      extraParams: composeParams()

      onInput: function(is: java.io.InputStream) {
        var ip = ItemParser {
          input: is
        }
        items = ip.parse();
        itemCount += sizeof items;
        resultsAvailable = ip.resultsAvailable;
        onResultsAvailable( items );
      }

      onDone: function() {
        if (itemCount < maxResults and itemCount < resultsAvailable) {
          createRequest();
          start();
        } else {
          onDone();
        }
      }
    }
  }

  function composeParams():String {
    var params = "SearchIndex={category}&Sort={sortBy}&{RESPONSE_GROUP}"
                 "&ItemPage={requestCount}";
    if (keywords.length() > 0) {
      params = "{params}&Keywords={keywords.<<replace>>(" ", "+")}";
    }
    params;
  }
}

