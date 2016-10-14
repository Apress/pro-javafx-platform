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
package projavafx.bookstorefx.ui;

import java.lang.Math;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.shape.Line;
import projavafx.bookstorefx.model.Item;
import projavafx.bookstorefx.model.ImageCache;
import projavafx.bookstorefx.ui.ItemSummary;

/**
 * @author Dean Iverson
 */
public class ItemCarousel extends CustomNode {
  public-init var imageCache: ImageCache;
  public var onShowDetails: function( item:Item );

  public var items: Item[] on replace {
    onShowDetails( items[0] );
    for (summary in itemSummaries) {
      var index = indexof summary;
      summary.item = items[index];
      summary.visible = if (indexof summary < sizeof items) true else false;
      summary.translateX = index * (ItemSummary.WIDTH + ITEM_GAP);
    }

    var listSize = sizeof items;
    guardsEnabled = (listSize > sizeof itemSummaries);
    itemRowWidth = (listSize * ItemSummary.WIDTH) + ((listSize - 1) * ITEM_GAP);
  }

  def ITEM_GAP = 15;
  def NODES_ON_SCREEN = 4;
  def SUMMARY_NODE_COUNT = NODES_ON_SCREEN + 3;

  var itemRow: Node;
  var itemRowWidth: Number;
  var itemSlider: Slider;
  var itemSummaries = for (i in [0..<SUMMARY_NODE_COUNT]) {
    ItemSummary {
      imageCache: imageCache
      onShowDetails: bind onShowDetails
    }
  }

  var guardsEnabled = false;
  var floaterIndex: Integer;
  var leftGuardIndex: Integer;
  var rightGuardIndex: Integer;
  var floaterItemIndex: Integer;
  var leftGuardItemIndex: Integer;
  var rightGuardItemIndex: Integer;

  postinit {
    leftGuardIndex = leftGuardItemIndex = 0;
    rightGuardIndex = rightGuardItemIndex = NODES_ON_SCREEN + 1;
    floaterIndex = floaterItemIndex = NODES_ON_SCREEN + 2;

    for (summary in itemSummaries) {
      summary.visible = false;
    }
  }

  override function create():Node {
    Group {
      content: [
        itemRow = Group {
          translateX: bind -x
          content: [
            Line {
              stroke: Color.rgb( 0, 0, 0, 0)
              endX: bind itemRowWidth
            },
            itemSummaries
          ]
        },
        itemSlider = Slider {
          translateY: bind ItemSummary.HEIGHT + 15;
          translateX: bind (itemSlider.scene.width - itemSlider.width) / 2;
          width: 600;
          maxValue: bind itemRowWidth - ItemSummary.WIDTH;
        }
      ]
    }
  }

  var sliderValue = bind itemSlider.currentValue on replace oldValue {
    if (sliderValue != oldValue) {
      if (not t.running or t.paused) {
        t.play();
      }
    }
  }

  def FRAMES_PER_SEC = 60.0;
  def FRAME_TIME = 1s / FRAMES_PER_SEC;
  def MIN_SPEED = 0.1;

  var x = 0.0 on replace {
    if (guardsEnabled) {
      // Is left guard on screen?
      if (itemSummaries[leftGuardIndex].boundsInParent.maxX > x and leftGuardItemIndex > 0) {
        moveFloaterToLeftGuard();
      } else if (itemSummaries[rightGuardIndex].boundsInParent.minX < x + scene.width and
      rightGuardItemIndex < (sizeof items) - 1) {
        // Is right guard on screen?
        moveFloaterToRightGuard();
      }
    }
  }

  var speed: Number on replace {
    if (Math.abs( speed ) < MIN_SPEED) {
      speed = 0;
      t.pause();
    }
  }

  var t: Timeline = Timeline {
    keyFrames: KeyFrame {
      time: FRAME_TIME
      action: function() {
        // Calculate acceleration needed to reach the target in 1 second
        // This is derived from the basic motion formula: dist = v*t + 0.5*a*t*t
        var accel = ((itemSlider.currentValue - x) / FRAMES_PER_SEC - speed) / (FRAMES_PER_SEC / 2);
        speed = speed + accel;
        x = x + speed;
      }
    }
    repeatCount: Timeline.INDEFINITE;
  }

  function moveFloaterToLeftGuard() {
    // Floater becomes the new left guard
    leftGuardItemIndex = leftGuardItemIndex - 1;
    leftGuardIndex = floaterIndex;
    itemSummaries[leftGuardIndex].translateX = leftGuardItemIndex * (ItemSummary.WIDTH + ITEM_GAP);
    itemSummaries[leftGuardIndex].item = items[leftGuardItemIndex];

    // Right guard becomes the new floater
    floaterItemIndex = rightGuardItemIndex;
    floaterIndex = rightGuardIndex;

    // Assign the new right guard
    rightGuardItemIndex--;
    if (rightGuardIndex > 0) {
      rightGuardIndex--;
    } else {
      rightGuardIndex = sizeof itemSummaries - 1;
    }
  }

  function moveFloaterToRightGuard() {
    // Floater becomes the new right guard
    rightGuardItemIndex = rightGuardItemIndex + 1;
    rightGuardIndex = floaterIndex;
    itemSummaries[rightGuardIndex].translateX = rightGuardItemIndex * (ItemSummary.WIDTH + ITEM_GAP);
    itemSummaries[rightGuardIndex].item = items[rightGuardItemIndex];

    // Left guard becomes the new floater
    floaterItemIndex = leftGuardItemIndex;
    floaterIndex = leftGuardIndex;

    // Assign the new left guard
    leftGuardItemIndex++;
    if (leftGuardIndex < sizeof itemSummaries - 1) {
      leftGuardIndex++;
    } else {
      leftGuardIndex = 0;
    }
  }
}

