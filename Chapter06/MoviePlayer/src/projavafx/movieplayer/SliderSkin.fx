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
 * SliderSkin.fx - A JavaFX Script that demonstrates how to write a basic
 * control: a horizontal slider.
 *
 * Developed 2009 by Dean Iverson as a JavaFX Script SDK 1.2 example
 * for the Pro JavaFX book.
 */

package projavafx.movieplayer;

import javafx.scene.control.Skin;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.paint.Paint;
import javafx.scene.shape.Rectangle;

/**
 * @author Dean Iverson
 */
public class SliderSkin extends Skin {
  public var trackArc = 10;
  public var trackHeight = 10.0;
  public var trackStrokeWidth = 1.0;
  public var trackStroke: Paint = Color.BLACK;
  public var trackFill: Paint = Color.TRANSPARENT;
  public var trackOpacity = 1.0;

  public var thumbArc = 10;
  public var thumbHeight = 10.0;
  public var thumbStrokeWidth = 1.0;
  public var thumbStroke: Paint = Color.BLACK;
  public var thumbFill: Paint = Color.BLACK;

  protected var lastDragPos: Number;

  protected var thumb: Node = Rectangle {
    arcWidth: bind thumbArc
    arcHeight: bind thumbArc
    translateX: bind thumbPosition
    width: bind thumbLength
    height: bind thumbHeight
    fill: bind thumbFill
    stroke: bind thumbStroke
    strokeWidth: bind thumbStrokeWidth
    onMousePressed: function(me:MouseEvent):Void {
      lastDragPos = 0;
    }
    onMouseDragged: horizontalDragger
  }

  protected var track: Node = Rectangle {
    arcWidth: bind trackArc
    arcHeight: bind trackArc
    x: 0
    y: bind (thumbHeight - trackHeight) / 2
    width: bind sliderLength
    height: bind trackHeight
    opacity: bind trackOpacity
    fill: bind trackFill
    stroke: bind trackStroke
    strokeWidth: bind trackStrokeWidth
  }

  var slider = bind control as Slider on replace {
    if (slider != null) {
      node = Group {
        content: [track,thumb]
      }
    }
  }

  var sliderLength = bind slider.width;
  var sliderValue = bind slider.currentValue on replace {
    setThumbPositionFromSliderValue();
  }

  var thumbLength = bind (control as Slider).thumbLength;
  var trackLength = bind sliderLength - thumbLength on replace {
    setThumbPositionFromSliderValue();
  }

  /**
   * Current thumb position, range: 0.0 -> trackLength.
   */
  var thumbPosition = 0.0 on replace {
    if (thumbPosition < 0.0) {
      thumbPosition = 0.0;
    } else if (trackLength > 0.0 and thumbPosition > trackLength) {
      thumbPosition = trackLength;
    }
  }

  override function contains( localX: Number, localY: Number ) {
    return node.contains(localX, localY);
  }

  override function intersects(localX: Number, localY: Number, localWidth: Number, localHeight: Number) {
    return node.intersects(localX, localY, localWidth, localHeight);
  }

  function horizontalDragger(me:MouseEvent):Void {
    var boundsInScene = thumb.localToScene(thumb.boundsInLocal);
    var leftThreshold = boundsInScene.minX + thumbLength / 2;
    var rightThreshold = boundsInScene.maxX - thumbLength / 2;
    if ((thumbPosition == 0 and me.sceneX < leftThreshold) or
      (thumbPosition == trackLength and me.sceneX > rightThreshold)) {
      return;
    }

    setSliderValueFromThumbPosition( thumbPosition + me.dragX - lastDragPos );
    lastDragPos = me.dragX;
  }

  function setSliderValueFromThumbPosition( position:Number ) {
    if (slider != null) {
      var range = slider.maxValue - slider.minValue;
      slider.currentValue = slider.minValue + range * position / trackLength;
    }
  }

  function setThumbPositionFromSliderValue() {
    var currentPos = slider.currentValue - slider.minValue;
    var range = slider.maxValue - slider.minValue;
    thumbPosition = if (range <= 0.0) 0 else trackLength * currentPos / range;
  }
}
