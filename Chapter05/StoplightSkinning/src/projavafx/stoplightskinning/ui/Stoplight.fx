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
 * Stoplight.fx - A JavaFX Script example program that
 * demonstrates how to create a skinnable UI control.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.stoplightskinning.ui;

import javafx.scene.Node;
import javafx.scene.control.Control;

public def STOP: Integer = 0;
public def CAUTION: Integer = 1;
public def GO: Integer = 2;

/**
 * The model for the StopLight control
 */
public class Stoplight extends Control {
  /**
   * The index of the selected light in the stoplight
   */
  public var selectedIndex: Integer = 0;

  /**
   * Make the next light bright
   */
  protected function nextLight() {
    selectedIndex = ++selectedIndex mod 3;
  }

  /**
   * Make the previous light bright
   */
  protected function prevLight() {
    selectedIndex = (--selectedIndex + 3) mod 3;
  }

  /**
   * Identify a default skin
   */
  override public function create():Node {
    skin = StoplightVerticalSkin {};
    super.create();
  }
}
