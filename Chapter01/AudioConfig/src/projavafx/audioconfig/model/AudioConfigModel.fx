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
 * AudioConfigModel.fx - The model class behind a JavaFX Script example
 * program that demonstrates "the way of JavaFX" (binding to model classes,
 * triggers, sequences, and declaratively expressed, node-centric UIs).
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.audioconfig.model;

/**
 * The model class that the AudioConfigMain.fx script uses
 */
public class AudioConfigModel {
  /**
   * The minimum audio volume in decibels
   */
  public def minDecibels:Number = 0;

  /**
   * The maximum audio volume in decibels
   */
  public def maxDecibels:Number = 160;

  /**
   * The selected audio volume in decibels
   */
  public var selectedDecibels:Number;

  /**
   * Indicates whether audio is muted
   */
  public var muting:Boolean;  // false is default for Boolean

  /**
   * List of some musical genres
   */
  public def genres = [
    "Chamber",
    "Country",
    "Cowbell",
    "Metal",
    "Polka",
    "Rock"
  ];

  /**
   * Index of the selected genre
   */
  public var selectedGenreIndex:Integer on replace {
    if (genres[selectedGenreIndex] == "Chamber") {
      selectedDecibels = 80;
    }
    else if (genres[selectedGenreIndex] == "Country") {
      selectedDecibels = 100;
    }
    else if (genres[selectedGenreIndex] == "Cowbell") {
      selectedDecibels = 150;
    }
    else if (genres[selectedGenreIndex] == "Metal") {
      selectedDecibels = 140;
    }
    else if (genres[selectedGenreIndex] == "Polka") {
      selectedDecibels = 120;
    }
    else if (genres[selectedGenreIndex] == "Rock") {
      selectedDecibels = 130;
    }
  };
}