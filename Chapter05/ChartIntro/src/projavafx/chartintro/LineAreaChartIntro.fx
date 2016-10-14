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
import javafx.scene.chart.AreaChart;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.part.NumberAxis;
import javafx.util.Math;

/**
 * @author Dean Iverson
 */
Stage {
  title: "Line & Area Charts"
  scene: Scene {
    content: [ createLineChart(), createAreaChart() ]
  }
}

/**
 * An x axis that goes from 0 to 2*PI with labels every PI/2 radians.
 * The labels are formatted to display on 2 significant digits.
 */
function createXAxis() {
  NumberAxis {
    label: "Radians"
    upperBound: 2 * Math.PI
    tickUnit: Math.PI / 2
    formatTickLabel: function(value) {
      "{%.2f value}"
    }
  }
}

/**
 * A y axis that that goes from -1 to 1 with labels every 0.5 units.
 */
function createYAxis() {
  NumberAxis {
    upperBound: 1.0
    lowerBound: -1.0
    tickUnit: 0.5
  }
}

/**
 * Create a line chart to display sine and cosine values.
 */
function createLineChart() {
  LineChart {
    title: "Line Chart"
    showSymbols: false
    dataEffect: null
    xAxis: createXAxis()
    yAxis: createYAxis()
    data: [
      LineChart.Series {
        name: "Sine Wave"
        data: for (rads in [0..2*Math.PI step 0.01]) {
          LineChart.Data {
            xValue: rads
            yValue: Math.sin( rads )
          }
        }
      }
      LineChart.Series {
        name: "Cosine Wave"
        data: for (rads in [0..2*Math.PI step 0.01]) {
          LineChart.Data {
            xValue: rads
            yValue: Math.cos( rads )
          }
        }
      }
    ]
  }
}

/**
 * Create a area chart to display sine and cosine values.
 */
function createAreaChart() {
  AreaChart {
    title: "Area Chart"
    translateX: 550
    xAxis: createXAxis()
    yAxis: createYAxis()
    data: [
      AreaChart.Series {
        name: "Sine Wave"
        data: for (rads in [0..2*Math.PI step 0.01]) {
          AreaChart.Data {
            xValue: rads
            yValue: Math.sin( rads )
          }
        }
      }
      AreaChart.Series {
        name: "Cosine Wave"
        data: for (rads in [0..2*Math.PI step 0.01]) {
          AreaChart.Data {
            xValue: rads
            yValue: Math.cos( rads )
          }
        }
      }
    ]
  }
}