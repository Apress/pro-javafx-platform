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

import java.lang.Math;
import javafx.scene.image.Image;
import projavafx.bookstorefx.model.ImageCacheImpl;

/**
 * @author Dean Iverson
 */
public class ImageCache {
  public-init var cacheSize = 50;
  public-init var defaultWidth = 100;
  public-init var defaultHeight = 100;
  public-init var preserveAspectRatio = true;

  var map: ImageCacheImpl;

  postinit {
    map = new ImageCacheImpl( cacheSize, calculateCapacity(cacheSize), 0.75 );
  }

  public function getImage( url:String ):Image {
    getImage( url, defaultWidth, defaultHeight );
  }

  public function getImage( url:String, width:Integer, height:Integer ):Image {
    var image = map.get( url );
    if (image == null) {
      image = Image {
        url: url
        width: width
        height: height
        preserveRatio: preserveAspectRatio
        backgroundLoading: true
        placeholder: Image {
          url: "{__DIR__}images/loading{if (width > 100) "150" else "80"}.png"
        }
      }
      map.put( url, image );
    }
    return image as Image;
  }

  public function clear() {
    map.clear();
  }

  public function size() {
    map.size();
  }

  function calculateCapacity( cacheSize:Integer ):Integer {
    Math.ceil( cacheSize / 0.75 ) + 1 as Integer;
  }
}
