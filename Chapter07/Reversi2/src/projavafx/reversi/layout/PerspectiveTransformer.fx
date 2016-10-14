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
 * PerspectiveTransformer.fx - Part of the Reversi application example that illustrates
 * dynamic layout of Nodes in a JavaFX user interface utilitizing bind,
 * boxes, and Containers.
 *
 * Developed 2009 by Stephen Chin
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.reversi.layout;

import javafx.geometry.*;

/**
 * @author Stephen Chin
 */
public class PerspectiveTransformer {
  public-init var upperLeft:Point2D;
  public-init var upperRight:Point2D;
  public-init var lowerLeft:Point2D;
  public-init var lowerRight:Point2D;

  var m00:Number;
  var m01:Number;
  var m02:Number;
  var m10:Number;
  var m11:Number;
  var m12:Number;
  var m20:Number;
  var m21:Number;
  var m22:Number;

  init {
    buildUnitToQuadMatrix();
  }

  function buildUnitToQuadMatrix() {
    def dx1 = upperRight.x - lowerRight.x;
    def dx2 = lowerLeft.x - lowerRight.x;
    def dx3 = upperLeft.x - upperRight.x + lowerRight.x - lowerLeft.x;
    def dy1 = upperRight.y - lowerRight.y;
    def dy2 = lowerLeft.y - lowerRight.y;
    def dy3 = upperLeft.y - upperRight.y + lowerRight.y - lowerLeft.y;

    def inverseDeterminate = 1.0/(dx1*dy2 - dx2*dy1);
    m20 = (dx3*dy2 - dx2*dy3)*inverseDeterminate;
    m21 = (dx1*dy3 - dx3*dy1)*inverseDeterminate;
    m22 = 1.0;
    m00 = upperRight.x - upperLeft.x + m20*upperRight.x;
    m01 = lowerLeft.x - upperLeft.x + m21*lowerLeft.x;
    m02 = upperLeft.x;
    m10 = upperRight.y - upperLeft.y + m20*upperRight.y;
    m11 = lowerLeft.y - upperLeft.y + m21*lowerLeft.y;
    m12 = upperLeft.y;
  }

  public function transform(point:Point2D):Point2D {
    def w = m20 * point.x + m21 * point.y + m22;
    return Point2D {
        x: (m00 * point.x + m01 * point.y + m02) / w
        y: (m10 * point.x + m11 * point.y + m12) / w
    }
  }
}
