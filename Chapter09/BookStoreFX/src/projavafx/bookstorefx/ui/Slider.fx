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
 * Slider.fx - A JavaFX Script that demonstrates how to write a basic
 * control: a horizontal slider.
 *
 * Developed 2009 by Dean Iverson as a JavaFX Script SDK 1.2 example
 * for the Pro JavaFX book.
 */

package projavafx.bookstorefx.ui;

import javafx.scene.control.Control;

public class Slider extends Control {
  public var thumbLength = 10.0;
    
  public var minValue = 0.0 on replace {
    if (minValue > maxValue) {
      maxValue = minValue;
    }
  }

  public var maxValue = 100.0 on replace {
    if (maxValue < minValue) {
      minValue = maxValue;
    }
  }

  public var currentValue = 0.0 on replace {
    if (currentValue < minValue) {
      currentValue = minValue;
    } else if (currentValue > maxValue) {
      currentValue = maxValue;
    }
  }

  override var width = 100;
  override var height = 100;

  override function getMinWidth() {thumbLength}
  override function getMinHeight() {(skin as SliderSkin).trackHeight}

  override function getPrefWidth( height ) {maxValue - minValue}
  override function getPrefHeight( width ) {getMinHeight()}

  override function getMaxWidth() {Number.MAX_VALUE}
  override function getMaxHeight() {Number.MAX_VALUE}

  init {
    skin = SliderSkin {
    }
  }
}
