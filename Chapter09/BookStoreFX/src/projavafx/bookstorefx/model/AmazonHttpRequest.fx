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
 * AmazonHttpRequest.fx
 *
 * Created on Feb 15, 2009, 2:45:28 PM
 */

package projavafx.bookstorefx.model;

import javafx.io.http.HttpRequest;

/**
 * @author Dean Iverson
 */
public-read var requestsInProgress = 0;

package class AmazonHttpRequest {
  def ACCESS_KEY = "SUPPLYAWSKEYHERE";
  def BASE_URL = "http://ecs.amazonaws.com/onca/xml?Service=AWSECommerceService"
                 "&AWSAccessKeyId={ACCESS_KEY}&Version=2009-01-06";

  public-init var operation: String;
  public-init var extraParams: String;
  public-init var onInput: function( :java.io.InputStream ):Void;
  public-init var onError: function( message:String ):Void;
  public-init var onDone: function():Void;

  var request: HttpRequest;

  postinit {
    request = HttpRequest {
      method: HttpRequest.GET
      location: composeUrl()
      onInput: onInput
      onDone: function() {
        requestsInProgress--;
        if (request.responseCode != 200) {
          onError( request.responseMessage );
        }

        onDone();
      }

      onException: function(ex: java.lang.Exception) {
        onError("onException - exception: {ex.getClass()} {ex.getMessage()}");
      }
    }
  }

  public function start() {
    requestsInProgress++;
    request.start();
  }

  public function stop() {
    request.stop();
  }

  function composeUrl():String {
    "{BASE_URL}&Operation={operation}&{extraParams}";
  }
}

