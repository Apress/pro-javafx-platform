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
 * BookStoreModel.fx
 *
 * Created on Jan 25, 2009, 8:47:53 PM
 */

package projavafx.bookstorefx.model;

import projavafx.bookstorefx.model.Category;
import projavafx.bookstorefx.model.ImageCache;
import projavafx.bookstorefx.model.Item;
import projavafx.bookstorefx.model.SortBy;

/**
 * @author Dean Iverson
 */
public class BookStoreModel {
  def MAX_THUMBNAIL_WIDTH = 80;
  def MAX_THUMBNAIL_HEIGHT = MAX_THUMBNAIL_WIDTH * 1.33 as Integer;

  var currentSearch: AmazonItemSearch;

  public var keywords = "" on replace {
    if (currentSearch != null) {
      currentSearch.stop();
    }
    delete searchResults;

    if (keywords.length() > 0) {
      var search: AmazonItemSearch = AmazonItemSearch {
        sortBy: SortBy.SALES_RANK
        category: Category.BOOKS
        keywords: keywords
        maxResults: 50
        onResultsAvailable: function( items:Item[] ) {
          if (not search.canceled) {
            insert items into searchResults;
          }
        }
        onDone: function() {
          if (not search.canceled) {
            currentSearch = null;
          }
        }
      }
      currentSearch = search;
      currentSearch.start();
    }
  }

  public-read var imageCache = ImageCache {
    cacheSize: 100
    defaultWidth: MAX_THUMBNAIL_WIDTH
    defaultHeight: MAX_THUMBNAIL_HEIGHT
    preserveAspectRatio: true;
  }

  public-read var searchResults: Item[];
  public-read var topBooks: Item[];
  public-read var topMovies: Item[];
  public-read var topMusic: Item[];
  public-read var busy = bind AmazonHttpRequest.requestsInProgress > 0;

  postinit {
    AmazonTopSellers {
      category: Category.BOOKS
      onDone: function( items:Item[] ) {
        topBooks = items;
      }
    }.start();

    AmazonTopSellers {
      category: Category.MUSIC
      onDone: function( items:Item[] ) {
        topMusic = items;
      }
    }.start();

    AmazonTopSellers {
      category: Category.MOVIES
      onDone: function( items:Item[] ) {
        topMovies = items;
      }
    }.start();
  }
}

