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

package projavafx.chartintro;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.chart.part.NumberAxis;
import javafx.util.Math;
import javafx.scene.chart.ScatterChart;
import javafx.scene.chart.BubbleChart;

/**
 * @author Dean Iverson
 */
Stage {
  title: "Scatter & Bubble Charts"
  scene: Scene {
    content: [ createScatterChart(), createBubbleChart() ]
  }
}

/**
 * An x axis that goes from 0 to 1.0 and displays labels every 0.25 units.
 * The labels are formatted to display on 2 significant digits.
 */
function createAxis( label:String ) {
  NumberAxis {
    label: label
    upperBound: 1.0
    tickUnit: 0.25
    formatTickLabel: function(value) {
      "{%.2f value}"
    }
  }
}

/**
 * Create a scatter chart that displays random points.
 */
function createScatterChart() {
  ScatterChart {
    title: "Scatter Chart"
    legendVisible: false
    xAxis: createAxis( "X Axis" )
    yAxis: createAxis( "Y Axis" )
    data: [
      ScatterChart.Series {
        data: for (i in [1..100]) {
          ScatterChart.Data {
            xValue: Math.random();
            yValue: Math.random()
          }
        }
      }
    ]
  }
}

/**
 * Create a bubble chart to display random points.
 */
function createBubbleChart() {
  BubbleChart {
    title: "Bubble Chart"
    legendVisible: false
    translateX: 550
    xAxis: createAxis( "X Axis" )
    yAxis: createAxis( "Y Axis" )
    data: [
      BubbleChart.Series {
        data: for (i in [1..100]) {
          BubbleChart.Data {
            xValue: Math.random()
            yValue: Math.random()
            radius: i / 1000.0
          }
        }
      }
    ]
  }
}