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
package projavafx.bookstorefx.model;

import java.io.InputStream;
import javafx.data.pull.Event;
import javafx.data.pull.PullParser;
import java.lang.Math;

/**
 * @author Dean Iverson
 */
package class ItemParser {
    public-init var input: InputStream;
    public-read var resultsAvailable: Integer;

    public function parse():Item[] {
        var item: Item;
        var items: Item[];

        try {
            var parser: PullParser = PullParser {
                input: input
                documentType: PullParser.XML
                onEvent: function( e:Event ) {
                    if (e.type == PullParser.START_ELEMENT) {
                        if (e.qname.name == "Item") {
                            item = Item{
                            };
                        } else if (e.qname.name == "MediumImage") {
                            item.imageURL = parseImageUrl( parser );
                        } else if (e.qname.name == "LargeImage") {
                            item.detailedImageURL = parseImageUrl( parser );
                        } else if (e.qname.name == "Offers") {
                            item.price = parseOffers( parser );
                        }
                    } else if (e.type == PullParser.END_ELEMENT) {
                        if (e.qname.name == "Item") {
                            insert item into items;
                        } else if (e.qname.name == "Title") {
                            item.title = e.text;
                        } else if (e.qname.name == "Author") {
                            if (item.creator.length() == 0) {
                                item.creator = e.text;
                            } else {
                                item.creator = "{item.creator}, {e.text}";
                            }
                        } else if (e.qname.name == "AverageRating") {
                            item.rating = Math.round( Float.parseFloat(e.text) );
                            insert ["Avg Rating:", e.text] into item.details;
                        } else if (e.qname.name == "TotalReviews") {
                            insert ["Ratings:", e.text] into item.details;
                        } else if (e.qname.name == "TotalResults") {
                            resultsAvailable = Integer.parseInt(e.text);
                        }
                    }
                }
            }
            parser.parse();
        } finally {
            input.close();
        }

        return items;
    }

    function parseImageUrl( parser:PullParser ):String {
        parser.seek( "URL" );
        parser.forward();
        parser.event.text;
    }

    function parseOffers( parser:PullParser ):String {
        parser.seek( "FormattedPrice" );
        parser.forward();
        parser.event.text;
    }
}
