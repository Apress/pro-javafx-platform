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
 * AsyncProgressMain.fx - A JavaFX Script example program that demonstrates
 * a progress bar displaying the progress of an asynchronous task.
 *
 * Developed 2009 by James L. Weaver jim.weaver [at] javafxpert.com
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.asyncprogress.ui;

import projavafx.asyncprogress.model.*;

import javafx.scene.*;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.stage.Stage;

var vbox:VBox;

function startTask() {
  def progressBar:ProgressIndicator = ProgressBar {
    //progress: bind taskController.percentDone; //TODO: Bug in Task#percentDone? (reported to Akhil.K.Arora@sun.com)
    progress: bind taskController.progress / (taskController.maxProgress as Number);
  }
  def taskController:TaskController = TaskController {
    maxProg: 100 //TODO: This shouldn't be necessary
    //maxProgress: 100 //TODO: Shouldn't this be available? (reported to Akhil.K.Arora@sun.com)
    onStart:function():Void {
      insert progressBar into vbox.content;
    }
    onDone:function():Void {
      delete progressBar from vbox.content;
    }
  }
  taskController.start();
}

Stage {
  title: "Async and Progress Example"
  scene: Scene {
    width: 200
    height: 250
    content: vbox = VBox {
      layoutX: 10
      layoutY: 10
      spacing: 10
      content: [
        Button {
          text: "Start the task"
          action: function():Void {
            println("Starting TaskController");
            startTask();
          }
        }
      ]
    }
  }
}