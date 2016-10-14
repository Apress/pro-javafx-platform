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
 * Developed 2009 by Dean Iverson as a JavaFX Script SDK 1.2 example
 * for the Pro JavaFX book.
 */

package projavafx.whoismyrep.model;

import java.io.InputStream;
import javafx.data.pull.PullParser;
import javafx.io.http.HttpRequest;

public class ApplicationModel {
  public-read var senators: Senator[];
  public-read var representatives: Senator[];
  public-read var message: String on replace {
    println( "message: {message}" );
  }

  public var zipcode: String on replace {
    message = "";
    delete senators;
    delete representatives;

    if (zipcode.length() > 0) {
      var url = "http://whoismyrepresentative.com/getall_mems.php?"
                    "zip={zipcode}&output=json";
      var req: HttpRequest;

      req = HttpRequest {
        method: HttpRequest.GET
        location: url
        onInput: parseResponse
        onDone: function() {
          if (req.responseCode != 200) {
            message = req.responseMessage;
          } else if (sizeof senators == 0 and sizeof representatives == 0) {
            message = "No members found for {zipcode}";
          }
        }
        onException: function(ex: java.lang.Exception) {
          println("Exception: {ex.getClass()} {ex.getMessage()}");
        }
      }
      req.start();
    }
  }

  function setMemberProperty( member:Senator, name:String, value:String ) {
    if( name == "name" ) {
      member.name = value;
    } else if( name == "party" ) {
      member.party = value;
    } else if( name == "state" ) {
      member.state = value;
    } else if( name == "phone" ) {
      member.phone = value;
    } else if( name == "office" ) {
      member.office = value;
    } else if( name == "web" or name == "link") {
      member.website = value;
    } else if( name == "contact" ) {
      member.contact = value;
    } else if( name == "district" ) {
      if (member instanceof Representative) {
        (member as Representative).district = value;
      }
    }
  }

  function parseMemberOfCongress( member:Senator, parser:PullParser ) {
    while (parser.event.type != PullParser.END_DOCUMENT) {
      parser.forward();
      if (parser.event.type == PullParser.END_ARRAY_ELEMENT) {
        break;
      } else if (parser.event.type == PullParser.TEXT) {
        setMemberProperty( member, parser.event.name, parser.event.text );
      }
    }
  }

  function parseResponse( is:InputStream ) {
    try {
      var parser = PullParser {
        input: is
        documentType: PullParser.JSON;
      }

      while (parser.event.type != PullParser.END_DOCUMENT) {
        parser.seek( "type" );
        if (parser.event.type == PullParser.START_VALUE) {
          parser.forward();
          if (parser.event.text == "rep") {
            var rep = Representative{}
            parseMemberOfCongress( rep, parser );
            insert rep into representatives;
          } else if (parser.event.text == "sen" ) {
            var sen = Senator{}
            parseMemberOfCongress( sen, parser );
            insert sen into senators;
          }
        }
      }
    } finally {
      is.close();
    }
  }
}
