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
 * MediaSearchTest.fx - A JavaFX Script example program that
 * demonstrates how to build a rich Media Explorer application
 * that leverages layouts and utilities from the JFXtras project.
 *
 * Developed 2009 by Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.mediaexplorer;

import java.io.File;
import java.io.FileOutputStream;
import java.lang.System;
import java.util.Date;
import org.jfxtras.test.Expect.*;
import org.jfxtras.test.Expectation;
import org.jfxtras.test.ExpectationException;
import org.jfxtras.test.Test;

/**
 * @author Stephen Chin
 */
var mediaSearch: MediaSearch;

var mediaMatch = Expectation {
    describeAs: "media should match"
    apply: function(actual) {
        if (not mediaSearch.matches(actual as File)) {
            throw ExpectationException {
                actual: "media didn't match"
            }
        }
    }
}

var mediaFailMatch = Expectation {
    describeAs: "media should not match"
    apply: function(actual) {
        if (mediaSearch.matches(actual as File)) {
            throw ExpectationException {
                actual: "media matched"
            }
        }
    }
}

Test {
    say: "Media"
    var imageTempFile: File;
    var mediaTempFile: File;
    var otherTempFile: File;
    do: function() {
        mediaSearch = MediaSearch {};
        imageTempFile = File.createTempFile("image", ".jpg");
        mediaTempFile = File.createTempFile("media", ".flv");
        otherTempFile = File.createTempFile("other", ".foo");
    }
    test: [
        Test {
            say: "name search should"
            test: [
                Test {
                    say: "match"
                    do: function() {
                        mediaSearch.name = "image";
                        imageTempFile;
                    }
                    expect: mediaMatch
                }
                Test {
                    say: "fail"
                    do: function() {
                        mediaSearch.name = "something-else";
                        imageTempFile;
                    }
                    expect: mediaFailMatch
                }
            ]
        }
        Test {
            say: "date search should"
            var today = new Date();
            var beforeToday = new Date
                (System.currentTimeMillis() - 1000000000);
            var afterToday = new Date
                (System.currentTimeMillis() + 1000000000);
            test: [
                Test {
                    say: "match equals"
                    do: function() {
                        mediaSearch.dateOptions.selectedIndex = 1;
                        mediaSearch.date = mediaSearch.dateFormat.format(today);
                        imageTempFile;
                    }
                    expect: mediaMatch
                }
                Test {
                    say: "fail equals"
                    do: function() {
                        mediaSearch.dateOptions.selectedIndex = 1;
                        mediaSearch.date = mediaSearch.dateFormat.format(beforeToday);
                        imageTempFile;
                    }
                    expect: mediaFailMatch
                }
                Test {
                    say: "match before"
                    do: function() {
                        mediaSearch.dateOptions.selectedIndex = 2;
                        mediaSearch.date = mediaSearch.dateFormat.format(afterToday);
                        imageTempFile;
                    }
                    expect: mediaMatch
                }
                Test {
                    say: "fail before"
                    do: function() {
                        mediaSearch.dateOptions.selectedIndex = 2;
                        mediaSearch.date = mediaSearch.dateFormat.format(today);
                        imageTempFile;
                    }
                    expect: mediaFailMatch
                }
                Test {
                    say: "match after"
                    do: function() {
                        mediaSearch.dateOptions.selectedIndex = 3;
                        mediaSearch.date = mediaSearch.dateFormat.format(beforeToday);
                        imageTempFile;
                    }
                    expect: mediaMatch
                }
                Test {
                    say: "fail after"
                    do: function() {
                        mediaSearch.dateOptions.selectedIndex = 3;
                        mediaSearch.date = mediaSearch.dateFormat.format(today);
                        imageTempFile;
                    }
                    expect: mediaFailMatch
                }
            ]
        }
        Test {
            say: "size search should"
            do: function() {
                var writer = new FileOutputStream(imageTempFile);
                for (i in [1..
                    1024 * 5]) {
                    writer.write(0);
                }
                writer.close();
                null;
            }
            test: [
                Test {
                    say: "match equals"
                    do: function() {
                        mediaSearch.sizeOptions.selectedIndex = 1;
                        mediaSearch.size = "5";
                        imageTempFile;
                    }
                    expect: mediaMatch
                }
                Test {
                    say: "fail equals"
                    do: function() {
                        mediaSearch.sizeOptions.selectedIndex = 1;
                        mediaSearch.size = "8";
                        imageTempFile;
                    }
                    expect: mediaFailMatch
                }
                Test {
                    say: "match less than"
                    do: function() {
                        mediaSearch.sizeOptions.selectedIndex = 2;
                        mediaSearch.size = "10";
                        imageTempFile;
                    }
                    expect: mediaMatch
                }
                Test {
                    say: "fail less than"
                    do: function() {
                        mediaSearch.sizeOptions.selectedIndex = 2;
                        mediaSearch.size = "2";
                        imageTempFile;
                    }
                    expect: mediaFailMatch
                }
                Test {
                    say: "match greater than"
                    do: function() {
                        mediaSearch.sizeOptions.selectedIndex = 3;
                        mediaSearch.size = "1";
                        imageTempFile;
                    }
                    expect: mediaMatch
                }
                Test {
                    say: "fail greater than"
                    do: function() {
                        mediaSearch.sizeOptions.selectedIndex = 3;
                        mediaSearch.size = "21";
                        imageTempFile;
                    }
                    expect: mediaFailMatch
                }
            ]
        }
        Test {
            say: "type search"
            test: [
                Test {
                    say: "on both should"
                    test: [
                        Test {
                            say: "match images"
                            do: function() {
                                imageTempFile;
                            }
                            expect: mediaMatch
                        }
                        Test {
                            say: "match media"
                            do: function() {
                                mediaTempFile;
                            }
                            expect: mediaMatch
                        }
                        Test {
                            say: "not match other"
                            do: function() {
                                otherTempFile;
                            }
                            expect: mediaFailMatch
                        }
                    ]
                }
                Test {
                    say: "on images should"
                    do: function() {
                        mediaSearch.mediaTypes.selectedIndex = 1;
                    }
                    test: [
                        Test {
                            say: "match images"
                            do: function() {
                                imageTempFile;
                            }
                            expect: mediaMatch
                        }
                        Test {
                            say: "not match media"
                            do: function() {
                                mediaTempFile;
                            }
                            expect: mediaFailMatch
                        }
                        Test {
                            say: "not match other"
                            do: function() {
                                otherTempFile;
                            }
                            expect: mediaFailMatch
                        }
                    ]
                }
                Test {
                    say: "on media should"
                    do: function() {
                        mediaSearch.mediaTypes.selectedIndex = 2;
                    }
                    test: [
                        Test {
                            say: "not match images"
                            do: function() {
                                imageTempFile;
                            }
                            expect: mediaFailMatch
                        }
                        Test {
                            say: "match media"
                            do: function() {
                                mediaTempFile;
                            }
                            expect: mediaMatch
                        }
                        Test {
                            say: "not match other"
                            do: function() {
                                otherTempFile;
                            }
                            expect: mediaFailMatch
                        }
                    ]
                }
            ]
        }
    ]
}.perform();
