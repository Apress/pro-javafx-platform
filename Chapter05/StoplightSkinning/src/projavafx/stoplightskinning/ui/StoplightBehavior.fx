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
 * StoplightBehavior.fx - A JavaFX Script example program that
 * demonstrates how to create a skinnable UI control.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * and Chris Wright chris.wright [at] veriana.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */

package projavafx.stoplightskinning.ui;

import javafx.scene.control.Behavior;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.KeyEventID;

public class StoplightBehavior extends Behavior {

  /**
   * User has clicked the face of the stoplight.
   */
  public function facePressed():Void {
    def stoplightControl:Stoplight = (skin.control as Stoplight);
    if (stoplightControl.focused) {
      stoplightControl.nextLight();
    }
    else {
      stoplightControl.requestFocus();
    }
  }

  /**
   * This function is automatically called by the Control class when
   * a key event occurs.  When the user presses the up and down arrows,
   * make the lights cycle around in the direction of the arrow
   */
  override public function callActionForEvent(ke:KeyEvent):Void {
    if (ke.impl_EventID == KeyEventID.PRESSED) {
      def stoplightControl:Stoplight = (skin.control as Stoplight);
      if (ke.code == KeyCode.VK_DOWN or ke.code == KeyCode.VK_RIGHT) {
        stoplightControl.nextLight();
      }
      else if (ke.code == KeyCode.VK_UP or ke.code == KeyCode.VK_LEFT) {
        stoplightControl.prevLight();
      }
    }
  }
}
