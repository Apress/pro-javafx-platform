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
 * FileNavigator.fx - A JavaFX Script example program that
 * demonstrates how to build a rich Media Explorer application
 * that leverages layouts and utilities from the JFXtras project.
 *
 * Developed 2009 by Stephen Chin steve [at] widgetfx.org
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.mediaexplorer;

import java.io.File;
import java.io.FileFilter;
import java.io.FilenameFilter;
import javafx.ext.swing.SwingComboBox;
import javafx.ext.swing.SwingComboBoxItem;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import org.jfxtras.scene.ResizableCustomNode;
import org.jfxtras.scene.image.ImageUtil;
import org.jfxtras.scene.layout.ResizableVBox;
import org.jfxtras.scene.layout.ResizableHBox;

/**
 * @author Stephen Chin
 */
public var MEDIA_EXTENSIONS = ["flv", "fxm", "avi", "wmv", "mov"];

public function isMediaType(name:String) {
    sizeof MEDIA_EXTENSIONS[ext | name.toLowerCase().endsWith(ext)] >= 1
}

public class DirectoryNavigator extends ResizableCustomNode {
    
    public-read var currentDirectory = bind (mediaList.selectedItem as FileWrapper).file;

    public-read var mediaFiles:File[] = bind currentDirectory.listFiles(
        FilenameFilter {
            override function accept(dir, name) {
                return ImageUtil.imageTypeSupported(name) or isMediaType(name);
            }
        }
    );

    var parents:File[];

    var parentList = SwingComboBox {
        selectedIndex: 0
        items: bind [
            for (parent in parents) FileWrapper {file: parent}
            FileWrapper {}
        ]
    }

    var selectedParent = bind (parentList.selectedItem as FileWrapper).file;
    var roots:File[] = File.listRoots();
    var selectedFiles:File[] = bind selectedParent.listFiles(FileFilter {
        override function accept(file) {
            return file.isDirectory();
        }
    });
    var files:File[] = bind if (selectedParent == null) roots else selectedFiles;

    var mediaList:ListView = ListView {
        items: bind for (file in files) FileWrapper {file: file}
        onMouseClicked: function(e) {
            if (e.clickCount == 2) {
                navigateTo((mediaList.selectedItem as FileWrapper).file);
            }
        }
    }

    public function navigateTo(file:File) {
        parents = [];
        var parent = file;
        while (parent != null) {
            insert parent into parents;
            parent = parent.getParentFile();
        }
        parentList.selectedIndex = 0;
    }

    var upButton = Button {
        text: "Up"
        disable: bind parentList.selectedIndex >= parentList.items.size() - 1
        action: function() {
            parentList.selectedIndex++;
        }
    }

    override function create() {
        ResizableVBox {
            spacing: 2
            content: [
                ResizableHBox {
                    spacing: 3
                    content: [
                        parentList,
                        upButton
                    ]
                },
                mediaList
            ]
        }
    }
}

class FileWrapper extends SwingComboBoxItem {
    var file:File on replace {
        value = file;
        text = toString();
    }

    override function toString() {
        if (file == null) {
            "Root"
        } else if (file.getName().length() == 0) {
            file.toString()
        } else {
            file.getName()
        }
    }
}
