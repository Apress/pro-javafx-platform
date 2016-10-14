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

import javafx.scene.chart.PieChart;
import javafx.scene.chart.AreaChart;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.BubbleChart;
import javafx.scene.chart.ScatterChart;
import javafx.scene.text.Font;
import java.util.Random;

/**
 * @author Dean Iverson
 */
public class ChartDemoModel {
  def MAX_DATA = 5;
  def random = new Random();
  
  public-read def xAxisLimit = 200.0;
  public-read def yAxisLimit = 100.0;
  public-read def axisTickCount = 5.0;
  public-read def titleFont = Font { size: 24 }

  public-read def pieChartData = [
    PieChart.Data {
      value: 21
      label: "Pumpkin"
    },
    PieChart.Data {
      value: 33
      label: "Apple"
    }
    PieChart.Data {
      value: 17
      label: "Cherry"
    }
    PieChart.Data {
      value: 29
      label: "3.14159"
    }
  ];

  public def areaChartData = for (i in [1..<twoOrThree()]) {
    AreaChart.Series {
      def numPoints = fourOrFive();
      name: "Series {i}"
      data: for (j in [1..<numPoints]) {
        AreaChart.Data {
          xValue: j * xAxisLimit / numPoints;
          yValue: random.nextInt(yAxisLimit)
        }
      }
    }
  }

  public def barChartData = for (i in [1..twoOrThree()]) {
    BarChart.Series {
      def numPoints = fourOrFive();
      name: "Series {i}"
      data: for (j in [1..<numPoints]) {
        BarChart.Data {
          category: "Category {j}"
          value: random.nextInt(yAxisLimit)
        }
      }
    }
  }

  public-read def bubbleChartData = for (i in [1..twoOrThree()]) {
    BubbleChart.Series {
      def numPoints = fourOrFive();
      name: "Series {i}"
      data: for (j in [1..<numPoints]) {
        BubbleChart.Data {
          xValue: j * xAxisLimit / numPoints;
          yValue: random.nextInt(yAxisLimit)
          radius: 5 + random.nextInt(10)
        }
      }
    }
  }

  public-read def lineChartData = for (i in [1..twoOrThree()]) {
    LineChart.Series {
      def numPoints = fourOrFive();
      name: "Series {i}"
      data: for (j in [1..<numPoints]) {
        LineChart.Data {
          xValue: j * xAxisLimit / numPoints;
          yValue: random.nextInt(yAxisLimit)
        }
      }
    }
  }

  public-read def scatterChartData = for (i in [1..twoOrThree()]) {
    ScatterChart.Series {
      def numPoints = fourOrFive();
      name: "Series {i}"
      data: for (j in [1..<numPoints]) {
        ScatterChart.Data {
          xValue: j * xAxisLimit / numPoints;
          yValue: random.nextInt(yAxisLimit)
        }
      }
    }
  }

  function twoOrThree():Integer {
    3 - random.nextInt(1);
  }

  function fourOrFive():Integer {
    5 - random.nextInt(1);
  }
}
