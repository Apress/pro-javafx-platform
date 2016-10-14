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
 * BasicTest.fx - A JavaFX script example of the JFXtras and FEST-JavaFX
 * testing libraries.
 *
 * Developed 2009 by Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.test;

import javafx.util.Math.*;
import org.jfxtras.test.Test;
import org.jfxtras.test.Expect.*;
import projavafx.calc.Calculator;

/**
 * @author Stephen Chin
 */
Test {
    say: "A Calculator should"
    var calculator = Calculator {}
    test: [
        for (a in [0..9], b in [0..9]) {
            Test {
                say: "add {a} + {b}"
                do: function() {calculator.add(a, b)}
                expect: equalTo("{a + b}")
            }
        }
        for (aInt in [0..9], bInt in [1..9]) {
            var a = aInt as Number;
            var b = bInt as Number;
            [
                Test {
                    assume: that(a / b, closeTo(floor(a / b)))
                    say: "divide {a} / {b} without a decimal"
                    do: function() {calculator.divide(a, b)}
                    expect: equalTo("{(a / b) as Integer}")
                },
                Test {
                    assume: that(a / b, isNot(closeTo(floor(a / b))))
                    say: "divide {a} / {b} with a decimal"
                    do: function() {calculator.divide(a, b)}
                    expect: equalTo("{a / b}")
                }
            ]
        }
    ]
}.perform();
