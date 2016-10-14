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
 * MediaSearch.fx - A JavaFX Script example program that
 * demonstrates how to build a rich Media Explorer application
 * that leverages layouts and utilities from the JFXtras project.
 *
 * Developed 2009 by Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.mediaexplorer;

import java.io.File;
import javafx.ext.swing.SwingComboBox;
import javafx.ext.swing.SwingComboBoxItem;
import javafx.scene.control.Button;
import javafx.scene.control.TextBox;
import javafx.scene.shape.Line;
import javafx.scene.text.Text;
import org.jfxtras.async.JFXWorker;
import org.jfxtras.scene.ResizableCustomNode;
import org.jfxtras.scene.image.ImageUtil;
import org.jfxtras.scene.layout.MigLayout;
import org.jfxtras.scene.layout.MigLayout.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * @author Stephen Chin
 */
public class MediaSearch extends ResizableCustomNode {

    public var directory:File on replace {
        searchResults = [];
        resultText = "";
    }

    public var searchResults:File[];

    package var name:String;

    package var date:String;

    package var dateFormat = new SimpleDateFormat("MM/dd/yy");

    function getUserCalendar() {
        var calendar = Calendar.getInstance();
        calendar.setTime(dateFormat.parse(date));
        return calendar;
    }

    function getDayGranularityCalendar(date:Date) {
        var calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.clear(Calendar.HOUR);
        calendar.clear(Calendar.HOUR_OF_DAY);
        calendar.clear(Calendar.MINUTE);
        calendar.clear(Calendar.SECOND);
        calendar.clear(Calendar.MILLISECOND);
        return calendar;
    }

    package var dateOptions = SwingComboBox {
        items: [
            SwingComboBoxItem {
                text: "any"
                value: function(file:File):Boolean {true}
                selected: true
            }
            SwingComboBoxItem {
                text: "is"
                value: function(file:File):Boolean {
                    getDayGranularityCalendar(new Date(file.lastModified())).
                      equals(getUserCalendar());
                }
            }
            SwingComboBoxItem {
                text: "is before"
                value: function(file:File):Boolean {
                    getDayGranularityCalendar(new Date(file.lastModified())).
                      <<before>>(getUserCalendar());
                }
            }
            SwingComboBoxItem {
                text: "is after"
                value: function(file:File):Boolean {
                    getDayGranularityCalendar(new Date(file.lastModified())).
                      <<after>>(getUserCalendar());
                }
            }
        ]
    }

    package var size:String;

    function getSize():Integer {
        if (size.length() == 0) 0 else Integer.parseInt(size)
    }

    package var sizeOptions = SwingComboBox {
        items: [
            SwingComboBoxItem {
                text: "any"
                value: function(file:File):Boolean {true}
                selected: true
            }
            SwingComboBoxItem {
                text: "equals"
                value: function(file:File):Boolean {
                    file.length() / 1024 == getSize();
                }
            }
            SwingComboBoxItem {
                text: "is less than"
                value: function(file:File):Boolean {
                    file.length() / 1024 < getSize();
                }
            }
            SwingComboBoxItem {
                text: "is greater than"
                value: function(file:File):Boolean {
                    file.length() / 1024 > getSize();
                }
            }
        ]
    }

    package var mediaTypes = SwingComboBox {
        items: [
            SwingComboBoxItem {
                text: "any"
                selected: true
                value: function(file:File):Boolean {
                    ImageUtil.imageTypeSupported(file.getName()) or
                    DirectoryNavigator.isMediaType(file.getName())
                }
            }
            SwingComboBoxItem {
                text: "images"
                value: function(file:File):Boolean {
                    ImageUtil.imageTypeSupported(file.getName())
                }
            }
            SwingComboBoxItem {
                text: "videos"
                value: function(file:File):Boolean {
                    DirectoryNavigator.isMediaType(file.getName())
                }
            }
        ]
    }

    var worker:JFXWorker;
    var count:Integer;
    var resultText:String;

    var searchButton = Button {
        text: "Search"
        action: function() {
            worker.cancel();
            searchResults = [];
            count = 0;
            resultText = "Searching...";
            worker = JFXWorker {
                inBackground: function() {
                    search(directory);
                    return null;
                }
                process: function(data) {
                    var files = data as File[];
                    insert files[0..(24-count)] into searchResults;
                    count += sizeof data;
                    resultText = "Found {count} files";
                }
                onDone: function(results) {
                    if (count == 0) {
                        resultText = "No results found";
                    }
                }
            }
        }
    }

    package function matches(file:File):Boolean {
        var dateFilter = dateOptions.selectedItem.value as
                           function(:File):Boolean;
        var sizeFilter = sizeOptions.selectedItem.value as
                           function(:File):Boolean;
        var mediaFilter = mediaTypes.selectedItem.value as
                            function(:File):Boolean;
        return file.getName().contains(name) and dateFilter(file) and
               sizeFilter(file) and mediaFilter(file);
    }

    function search(directory:File):Void {
        var files = directory.listFiles();
        for (file in files) {
            if (worker.cancelled) {
                return;
            }
            if (file.isDirectory()) {
                search(file);
            } else if (matches(file)) {
                worker.publish([file]);
            }
        }
    }

    var cancelButton = Button {
        text: "Cancel"
        action: function() {
            worker.cancel();
        }
    }

    override function create() {
        MigLayout {
            constraints: "fill, wrap, insets 10"
            rows: "[][][][]4mm[][]push[]"
            columns: "[][][]"
            content: [
                migNode(Text {content: "Name"}, "alignx right"),
                migNode(TextBox {text: bind name with inverse}, "span, growx"),
                migNode(Text {content: "Date modified"}, "alignx right"),
                migNode(dateOptions, "growx"),
                migNode(TextBox {text: bind date with inverse}, "growx"),
                migNode(Text {content: "Size (KB)"}, "alignx right"),
                migNode(sizeOptions, "growx"),
                migNode(TextBox {text: bind size with inverse}, "growx"),
                migNode(Text {content: "Media type"}, "alignx right"),
                migNode(mediaTypes, "growx, wrap"),
                migNode(cancelButton, "span 2, tag cancel"),
                migNode(searchButton, "tag ok"),
                migNode(Text {content: bind resultText}, "span"),
                migNode(Line {endX: bind width - 24}, "span")
            ]
        }
    }
}
