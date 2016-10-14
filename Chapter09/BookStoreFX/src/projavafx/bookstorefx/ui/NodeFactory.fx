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
 package projavafx.bookstorefx.ui;

import javafx.fxd.Duplicator;
import javafx.fxd.FXDLoader;
import javafx.scene.Cursor;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import javafx.scene.Node;

import javafx.fxd.FXDContent;

/**
 * @author Dean Iverson
 */
var assets = FXDLoader.loadContent("{__DIR__}res/bookStoreAssets.fxz");
var headerBg = getAndUnparent(assets, "headerBg");
var mainBg = getAndUnparent(assets, "mainBg");
var logo = getAndUnparent(assets, "logo");
var homeTab = getAndUnparent(assets, "homeTab");
var home = getAndUnparent(assets, "home");
var searchTab = getAndUnparent(assets, "searchTab");
var search = getAndUnparent(assets, "search");
var cartTab = getAndUnparent(assets, "cartTab");
var cart = getAndUnparent(assets, "cart");
var cartImage = getAndUnparent(assets, "cartImage");
var detailsButton = getAndUnparent(assets, "detailsButton");
var detailsText = getAndUnparent(assets, "details");
var prodDetailsBg = getAndUnparent(assets, "prodDetailsBg");
var prodLargeBg = getAndUnparent(assets, "prodLargeBg");
var prodTitleBg = getAndUnparent(assets, "prodTitleBg");
var scrollBarBg = getAndUnparent(assets, "scrollBarBg");

var bookRes3 = FXDLoader.loadContent("{__DIR__}res/homePage.fxz");
var booksTable = getAndUnparent(bookRes3, "tableOutlineBooks");
var booksText = getAndUnparent(bookRes3, "books");
var booksLines = getAndUnparent(bookRes3, "linesBooks");
var booksMore = getAndUnparent(bookRes3, "moreBooks");
var booksUp = getAndUnparent(bookRes3, "upArrowBooks");
var booksDown = getAndUnparent(bookRes3, "downArrowBooks");

var musicTable = getAndUnparent(bookRes3, "tableOutlineMusic");
var musicText = getAndUnparent(bookRes3, "music");
var musicLines = getAndUnparent(bookRes3, "linesMusic");
var musicMore = getAndUnparent(bookRes3, "moreMusic");
var musicUp = getAndUnparent(bookRes3, "upArrowMusic");
var musicDown = getAndUnparent(bookRes3, "downArrowMusic");

var videoTable = getAndUnparent(bookRes3, "tableOutlineVideo");
var videoText = getAndUnparent(bookRes3, "video");
var videoLines = getAndUnparent(bookRes3, "linesVideo");
var videoMore = getAndUnparent(bookRes3, "moreVideo");
var videoUp = getAndUnparent(bookRes3, "upArrowVideo");
var videoDown = getAndUnparent(bookRes3, "downArrowVideo");

function getAndUnparent( content:FXDContent, id:String ) {
  var node = content.getNode(id);
  delete node from (node.parent as Group).content;
  node;
}

public function getBackground():Node {
    delete mainBg from (mainBg.parent as Group).content;
    Group {
        content: [mainBg, headerBg]
    }
}

public function getLogo() {
    logo;
}

public function getViewingWhatsHot() {
    getAndUnparent(bookRes3, "viewingWhatsHot");
}

public function getBookStackFrame( upAction:function(), downAction:function() ):Node {
    makeButton( booksUp, upAction );
    makeButton( booksDown, downAction );
    Group {
        content: [booksTable, booksLines, booksText, booksMore, booksUp, booksDown]
    }
}

public function getMusicStackFrame( upAction:function(), downAction:function() ):Node {
    makeButton( musicUp, upAction );
    makeButton( musicDown, downAction );
    Group {
        content: [musicTable, musicLines, musicText, musicMore, musicUp, musicDown]
    }
}

public function getMovieStackFrame( upAction:function(), downAction:function() ):Node {
    makeButton( videoUp, upAction );
    makeButton( videoDown, downAction );
    Group {
        content: [videoTable, videoLines, videoText, videoMore, videoUp, videoDown]
    }
}

public function getItemDetailsBackground():Node {
    Group {
        content: [prodDetailsBg, prodLargeBg, prodTitleBg]
    }
}

public function createDetailsButton( onAction: function() ):Node {
    var button = Duplicator.duplicate( detailsButton );
    makeButton( button, onAction );
    Group {
        content: [
            button,
            Duplicator.duplicate( detailsText ),
        ]
    }
}

public function getHeader( onHome:function(), onSearch:function(), onCart:function() ):Node {
    makeButton( homeTab, onHome );
    makeButton( searchTab, onSearch );
    makeButton( cartTab, onCart );
    Group {
        //translateX: -100
        content: [
            homeTab,
            home,
            searchTab,
            search,
            cartTab,
            cart,
            cartImage
        ]
    }
}

public function makeButton( button:Node, func:function() ) {
    button.cursor = Cursor.HAND;
    button.onMousePressed = function( me:MouseEvent ) {
        func();
    }
}
