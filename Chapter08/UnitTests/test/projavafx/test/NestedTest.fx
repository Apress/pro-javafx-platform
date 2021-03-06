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

import javafx.util.Sequences;
import org.jfxtras.test.Test;
import org.jfxtras.test.Expect.*;

/**
 * @author Stephen Chin
 */
Test {
    say: "Every sequence"
    var sequence:Integer[];
    do: function() {
        sequence = [1, 2, 3, 4];
        null;
    }
    test: [
        Test {
            say: "should have a max"
            do: function() {Sequences.max(sequence)}
            expect: equalTo(4)
        }
        Test {
            say: "should have a min"
            do: function() {Sequences.min(sequence)}
            expect: equalTo(1)
        }
    ]
}.perform();
