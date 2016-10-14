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

package projavafx.chartdemo;

import javafx.scene.CustomNode;
import javafx.scene.layout.Resizable;
import javafx.scene.Group;
import javafx.scene.chart.Chart;
import javafx.scene.transform.Scale;
import javafx.util.Math;
import javafx.animation.Timeline;
import javafx.animation.transition.ParallelTransition;
import javafx.animation.transition.TranslateTransition;
import javafx.geometry.BoundingBox;
import javafx.scene.input.MouseEvent;
import javafx.scene.shape.Rectangle;

import javafx.scene.paint.Color;

/**
 * @author Dean Iverson
 */
public class ChartViewer extends CustomNode, Resizable {
  def DEFAULT_HEIGHT = 100.0;
  def GAP_SIZE = 10.0;
  def ASPECT_RATIO = 4.0 / 3.0;

  var thumbnailWidth = DEFAULT_HEIGHT * ASPECT_RATIO;
  var thumbnailHeight = DEFAULT_HEIGHT;
  var mainWidth = DEFAULT_HEIGHT * ASPECT_RATIO;
  var mainHeight = DEFAULT_HEIGHT;

  var selectedChart = 0;
  var currentBounds:BoundingBox[];
  var scaleTransforms:Scale[];
  var switchTransition:ParallelTransition;

  /**
   * The sequence of charts to display.
   */
  public-init var charts:Chart[] on replace {
    // Create a scale transform for each chart and save a reference
    // to each one in the scaleTransforms sequence for easy manipulation.
    for (chart in charts) {
      var s = Scale{}
      insert s into scaleTransforms;
      chart.transforms = s;
    }

    layoutCharts();
  }

  /**
   * This node always fills the scene.
   */
  override var width = bind scene.width on replace {
    layoutCharts();
  }

  /**
   * This node always fills the scene.
   */
  override var height = bind scene.height on replace {
    layoutCharts();
  }

  override function getPrefWidth(height) { 400 }
  override function getPrefHeight(width) { 300 }

  /**
   * The contents of the custom node is the charts with a transparent
   * rectangle overlay to catch mouse clicks (since I haven't figured
   * out how to reliably catch mouse clicks on charts yet).
   */
  override function create() {
    Group {
      content: [
        charts,
        Rectangle {
          width: bind width
          height: bind height
          fill: Color.TRANSPARENT
          onMousePressed: clickHandler
        }
      ]
    }
  }

  /**
   * Handle mouse clicks in the node.  Figure out which chart was clicked
   * and, if it was a thumbnail, start the movement animation.
   */
  function clickHandler(me:MouseEvent) {
    for (chart in charts) {
      if (indexof chart != selectedChart and chart.localToParent(chart.boundsInLocal).contains( me.x, me.y )) {
        moveToCenter( indexof chart);
        return;
      }
    }
  }

  /**
   * Peform the layout:
   *  1: Calculate the thumbnail and main chart sizes.
   *  2: Calculate the new bounds of each chart based on the new sizes.
   *  3: Use the new bounds to set the translate and scale of each chart.
   */
  function layoutCharts() {
    calculateSizes();
    currentBounds = calculateBounds(selectedChart);

    for (chart in charts) {
      var bounds = currentBounds[indexof chart];
      chart.translateX = bounds.minX;
      chart.translateY = bounds.minY;

      var scale = scaleTransforms[indexof chart];
      scale.x = bounds.width / chart.width;
      scale.y = bounds.height / chart.height;
    }
  }

  /**
   * Calculate what the thumbnail size should be based on the size of this node
   * and the number of charts being displayed.  Then calcualte the size of the
   * main chart based on the space left over.
   */
  function calculateSizes() {
    thumbnailWidth = Math.min( width / (sizeof charts - 1) - (2 * GAP_SIZE), 100 * ASPECT_RATIO);
    thumbnailHeight = Math.min(100.0, thumbnailWidth / ASPECT_RATIO);
    mainWidth = Math.min((height - thumbnailHeight) * ASPECT_RATIO, width) - GAP_SIZE;
    mainHeight = Math.min(height - thumbnailHeight, width / ASPECT_RATIO) - GAP_SIZE;
  }

  /**
   * Calculate a BoundingBox for each chart depending on whether it is the
   * currently selected chart or a thumbnail.
   */
  function calculateBounds(centerChartIndex:Integer) {
    var x = GAP_SIZE;

    for (chart in charts) {
      if (indexof chart != centerChartIndex) {
        var bounds = BoundingBox {
          width: thumbnailWidth
          height: thumbnailHeight
          minX: x;
          minY: GAP_SIZE;
        }
        x += 2*GAP_SIZE + thumbnailWidth;
        bounds;
      } else {
        BoundingBox {
          width: mainWidth
          height: mainHeight
          minX: (width - mainWidth) / 2
          minY: thumbnailHeight + GAP_SIZE
        }
      }
    }
  }

  /**
   * Creates and plays the animation to move a new chart to the main chart area
   * and shuffle the thumbnails if needed.
   */
  function moveToCenter(thumbnailIndex:Integer) {
    if (switchTransition.running)
      return;

    def duration = 0.5s;
    def startIndex = Math.min(thumbnailIndex, selectedChart);
    def endIndex = Math.max(thumbnailIndex, selectedChart);
    def newBounds = calculateBounds(thumbnailIndex);
    
    switchTransition = ParallelTransition {
      action: function() {
        selectedChart = thumbnailIndex;
        layoutCharts();
      }
      content: for (chart in charts[startIndex..endIndex]) {
        def chartIndex = startIndex + indexof chart;
        def bounds = newBounds[chartIndex];
        def scale = scaleTransforms[chartIndex];
        [
          TranslateTransition {
            node: chart
            duration: duration
            toX: bounds.minX
            toY: bounds.minY
          },
          Timeline {
            keyFrames: at(0.5s) {
              scale.x => bounds.width / chart.width;
              scale.y => bounds.height / chart.height;
            }
          }
        ]
      }
    }
    switchTransition.play();
  }
}
