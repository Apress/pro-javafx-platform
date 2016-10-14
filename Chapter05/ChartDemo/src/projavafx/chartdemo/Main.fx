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

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.chart.part.CategoryAxis;
import javafx.scene.chart.AreaChart;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.BubbleChart;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.PieChart;
import javafx.scene.chart.ScatterChart;
import javafx.scene.chart.part.NumberAxis;

/**
 * @author Dean Iverson
 */
def model = ChartDemoModel {}

def charts = [
  areaChart(),
  barChart(),
  bubbleChart(),
  lineChart(),
  pieChart(),
  scatterChart(),
];

Stage {
  title: "Chart Demo"
  scene: Scene {
    width: 640
    height: 480
    content: [
      ChartViewer {
        charts: charts
      }
    ]
  }
}

function createXAxis() {
  NumberAxis {
    label: "X Axis"
    upperBound: model.xAxisLimit
    tickUnit: model.xAxisLimit / model.axisTickCount
  }
}

function createYAxis() {
  NumberAxis {
    label: "Y Axis"
    upperBound: model.yAxisLimit
    tickUnit: model.yAxisLimit / model.axisTickCount
  }
}

function areaChart() {
  AreaChart {
    title: "Area Chart"
    titleFont: model.titleFont
    xAxis: createXAxis()
    yAxis: createYAxis()
    data: model.areaChartData
  }
}

function barChart() {
  BarChart {
    title: "Bar Chart"
    titleFont: model.titleFont
    categoryAxis: CategoryAxis {
        categories: [ "Category 1", "Category 2", "Category 3" ]
        endMargin: 25
        startMargin: 25
    }
    valueAxis: createYAxis()
    data: model.barChartData
  }
}

function bubbleChart() {
  BubbleChart {
    title: "Bubble Chart"
    titleFont: model.titleFont
    xAxis: createXAxis()
    yAxis: createYAxis()
    data: model.bubbleChartData
  }
}

function lineChart() {
  LineChart {
    title: "Line Chart"
    titleFont: model.titleFont
    xAxis: createXAxis()
    yAxis: createYAxis()
    data: model.lineChartData
  }
}

function pieChart() {
  PieChart {
    title: "What Is Your Favorite Pie?"
    titleFont: model.titleFont
    data: model.pieChartData
  }
}

function scatterChart() {
  ScatterChart {
    title: "Scatter Chart"
    titleFont: model.titleFont
    xAxis: createXAxis()
    yAxis: createYAxis()
    data: model.scatterChartData
  }
}

