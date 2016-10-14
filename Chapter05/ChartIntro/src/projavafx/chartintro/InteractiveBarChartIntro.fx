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
import javafx.scene.chart.BarChart;
import javafx.scene.chart.part.CategoryAxis;
import javafx.scene.chart.part.NumberAxis;
import javafx.scene.text.Font;
import javafx.stage.Alert;

/**
 * @author Dean Iverson
 */
def years = [ "2007", "2008", "2009" ];

def anvilsSold = [  567, 1292, 2423 ];
def skatesSold = [  956, 1665, 2559 ];
def pillsSold = [ 1154, 1927, 2774 ];

Stage {
  title: "Bar Chart Intro"
  scene: Scene {
    content: [
      BarChart {
        title: "Acme, Inc. Sales Report"
        titleFont: Font { size: 24 }
        categoryGap: 25
        categoryAxis: CategoryAxis {
            categories: years
        }
        valueAxis:   NumberAxis {
          label: "Units Sold"
          upperBound: 3000
          tickUnit: 1000
        }
        data: [
          BarChart.Series {
            def product = "Anvils"
            name: product
            data: for (j in [0..<sizeof years]) {
              BarChart.Data {
                category: years[j]
                value: anvilsSold[j]
                action: function() {
                  showAlert( years[j], product, anvilsSold[j] )
                }
              }
            }
          }
          BarChart.Series {
            def product = "Rocket Skates"
            name: product
            data: for (j in [0..<sizeof years]) {
              BarChart.Data {
                category: years[j]
                value: skatesSold[j]
                action: function() {
                  showAlert( years[j], product, skatesSold[j] )
                }
              }
            }
          }
          BarChart.Series {
            def product = "Earthquake Pills"
            name: product
            data: for (j in [0..<sizeof years]) {
              BarChart.Data {
                category: years[j]
                value: pillsSold[j]
                action: function() {
                  showAlert( years[j], product, pillsSold[j] )
                }
              }
            }
          }
        ]
      }
    ]
  }
}

function showAlert( year:String, product:String, unitsSold:Integer ) {
  Alert.inform( "Acme, Inc sold {unitsSold} {product} in {year}" );
}
