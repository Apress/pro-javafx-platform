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

import javafx.animation.Interpolator;
import javafx.animation.Interpolator.*;
import javafx.animation.Timeline;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import projavafx.bookstorefx.model.BookStoreModel;
import projavafx.bookstorefx.ui.NodeFactory;

/**
 * @author Dean Iverson
 */
public class HomePage extends CustomNode {
  public-init var model: BookStoreModel;

  def STACK_ITEM_START_Y = 82;
  def STACK_ITEM_HEIGHT = 130;
  def STACK_ITEM_COUNT = 5;

  var bookStack: Group = Group {
    var bframe: Node;
    var bstack = ItemStack {
      x: bind bframe.layoutBounds.minX
      y: STACK_ITEM_START_Y
      stackItemCount: STACK_ITEM_COUNT
      stackItemHeight: STACK_ITEM_HEIGHT
      imageCache: model.imageCache
      items: bind model.topBooks
    }

    content: [
      bframe = NodeFactory.getBookStackFrame( bstack.up, bstack.down ),
      bstack
    ]
  }

  var musicStack: Group = Group {
    var frame: Node;
    var stack = ItemStack {
      x: bind frame.layoutBounds.minX
      y: STACK_ITEM_START_Y
      stackItemCount: STACK_ITEM_COUNT
      stackItemHeight: STACK_ITEM_HEIGHT
      imageCache: model.imageCache
      items: bind model.topMusic
    }

    content: [
      frame = NodeFactory.getMusicStackFrame( stack.up, stack.down ),
      stack
    ]
  }

  var movieStack: Group = Group {
    var frame: Node;
    var stack = ItemStack {
      x: bind frame.layoutBounds.minX
      y: STACK_ITEM_START_Y
      stackItemCount: STACK_ITEM_COUNT
      stackItemHeight: STACK_ITEM_HEIGHT
      imageCache: model.imageCache
      items: bind model.topMovies
    }

    content: [
      frame = NodeFactory.getMovieStackFrame( stack.up, stack.down ),
      stack
    ]
  }

  public function pageOutTransition():Timeline {
    Timeline {
      keyFrames: [
        at(0s) {
          bookStack.translateX => 0 tween LINEAR;
          musicStack.translateY => 0 tween LINEAR;
          movieStack.translateX => 0 tween LINEAR;
        }
        at(0.25s) {
          bookStack.translateX => -bookStack.layoutBounds.width tween LINEAR;
          musicStack.translateY => musicStack.scene.height tween LINEAR;
          movieStack.translateX => movieStack.layoutBounds.width tween LINEAR;
        }
      ]
    }
  }

  public function pageInTransition():Timeline {
    Timeline {
      keyFrames: [
        at(0s) {
          bookStack.translateX => -bookStack.layoutBounds.width tween LINEAR;
          musicStack.translateY => musicStack.scene.height tween LINEAR;
          movieStack.translateX => movieStack.layoutBounds.width tween LINEAR;
        }
        at(0.25s) {
          bookStack.translateX => 0 tween LINEAR;
          musicStack.translateY => 0 tween LINEAR;
          movieStack.translateX => 0 tween LINEAR;
        }
      ]
    }
  }

  override function create() {
    Group {
      content: [
        NodeFactory.getViewingWhatsHot(),
        bookStack,
        musicStack,
        movieStack,
      ]
    }
  }
}
