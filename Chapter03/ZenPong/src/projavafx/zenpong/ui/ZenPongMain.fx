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
 * ZenPongMain.fx - A simple example of the "intersects" script and 
 * the KeyFrame action event handler to create a very basic Pong game.
 *
 * Developed 2009 by Chris Wright (chris.wright [at] veriana.com) and
 * James L. Weaver (jim.weaver [at] javafxpert.com)
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.zenpong.ui;

import javafx.animation.*;
import javafx.scene.*;
import javafx.scene.control.Button;
import javafx.scene.input.*;
import javafx.scene.paint.*;
import javafx.scene.shape.Circle;
import javafx.scene.shape.Rectangle;
import javafx.stage.Stage;

/**
 * The center points of the moving ball
 */
var centerX: Number;
var centerY: Number;

/**
 * The Y coordinate of the left paddle
 */
var leftPaddleY: Number;

/**
 * The Y coordinate of the right paddle
 */
var rightPaddleY: Number;

/**
 * The moving ball
 */
var ball: Circle;

/**
 * The Group containing all of the walls, paddles, and ball.  This also allows
 * us to requestFocus for KeyEvents on the Group
 */
var pongComponents: Group;

/**
 * The left and right paddles
 */
var leftPaddle: Rectangle;
var rightPaddle: Rectangle;

/**
 * The walls
 */
var topWall: Rectangle;
var rightWall: Rectangle;
var leftWall: Rectangle;
var bottomWall: Rectangle;

/**
 * Controls whether the startButton is visible
 */
var startVisible: Boolean = true;

/**
 * The animation of the ball
 */
var pongAnimation: Timeline;

/**
 * Controls whether the ball is moving right
 */
var movingRight: Boolean = true;

/**
 * Controls whether the ball is moving down
 */
var movingDown: Boolean = true;

/**
 * The action calls the "checkForCollision" function to control the
 * direction of the ball.
 */
pongAnimation = Timeline {
  keyFrames: KeyFrame {
    time: 10ms
    action: function():Void {
      checkForCollision();
      centerX += if (movingRight) 1 else -1;
      centerY += if (movingDown) 1 else -1;
    }
  }
  repeatCount: Timeline.INDEFINITE
};

/**
 * Sets the inital starting positions of the ball and paddles
 */
function initialize():Void {
  centerX = 250;
  centerY = 250;
  leftPaddleY = 235;
  rightPaddleY = 235;
  startVisible = true;
  pongComponents.requestFocus();
}

/**
 * Checks whether or not the ball has collided with either the paddles,
 * topWall, or bottomWall.  If the ball hits the wall behind the paddles,
 * the game is over.
 */
function checkForCollision() {
  if (ball.intersects(rightWall.boundsInLocal) or
      ball.intersects(leftWall.boundsInLocal)) {
    pongAnimation.stop();
    initialize();
  }
  else if (ball.intersects(bottomWall.boundsInLocal) or
           ball.intersects(topWall.boundsInLocal)) {
    movingDown = not movingDown;
  }
  else if (ball.intersects(leftPaddle.boundsInLocal) and not movingRight) {
    movingRight = not movingRight;
  }
  else if (ball.intersects(rightPaddle.boundsInLocal) and movingRight) {
    movingRight = not movingRight;
  }
}

Stage {
  title: "ZenPong Example"
  scene: Scene {
    width: 500
    height: 500
    fill: LinearGradient {
      startX: 0.0,
      startY: 0.0,
      endX: 0.0,
      endY: 1.0
      stops: [
        Stop {
          offset: 0.0
          color: Color.BLACK
        },
        Stop {
          offset: 1.0
          color: Color.GRAY
        }
      ]
    }
    content: [
      /*
       * Note that each wall must have a height and width of at least one
       * pixel for the Node intersects function to work.
       */
      pongComponents = Group {
        focusTraversable: true
        content: [
          ball = Circle {
            centerX: bind centerX
            centerY: bind centerY
            radius: 5
            fill: Color.WHITE
          },
          topWall = Rectangle {
            x: 0
            y: 0
            width: 500
            height: 1
          },
          leftWall = Rectangle {
            x: 0
            y: 0
            width: 1
            height: 500
          },
          rightWall = Rectangle {
            x: 500
            y: 0
            width: 1
            height: 500
          },
          bottomWall = Rectangle {
            x: 0
            y: 500
            width: 500
            height: 1
          },
          leftPaddle = Rectangle {
            var dragStartY: Number = 0;
            x: 20
            y: bind leftPaddleY
            width: 10
            height: 30
            fill: Color.LIGHTBLUE
            onMousePressed: function(me:MouseEvent):Void {
              dragStartY = leftPaddle.y;
            }
            onMouseDragged: function(me:MouseEvent):Void {
              leftPaddleY = dragStartY + me.dragY;
            }
          },
          rightPaddle = Rectangle {
            var dragStartY: Number = 0;
            x: 470
            y: bind rightPaddleY
            width: 10
            height: 30
            fill: Color.LIGHTBLUE
            onMousePressed: function(me:MouseEvent):Void {
              dragStartY = rightPaddle.y;
            }
            onMouseDragged: function(me:MouseEvent):Void {
              rightPaddleY = dragStartY + me.dragY;
            }
          }
        ]
        /**
         * Controls the movement of the left and right paddles
         * Left paddle: A(up), Z(down)
         * Right paddle: Up Arrow(up), Down Arrow(down)
         */
        onKeyPressed: function(k:KeyEvent):Void {
          if (k.code == KeyCode.VK_UP and
              not rightPaddle.intersects(topWall.boundsInLocal)) {
            rightPaddleY -= 6;
          }
          else if (k.code == KeyCode.VK_DOWN and
              not rightPaddle.intersects(bottomWall.boundsInLocal)) {
            rightPaddleY += 6;
          }
          else if (k.code == KeyCode.VK_A and
              not leftPaddle.intersects(topWall.boundsInLocal)) {
            leftPaddleY -= 6;
          }
          else if (k.code == KeyCode.VK_Z and
              not leftPaddle.intersects(bottomWall.boundsInLocal)) {
            leftPaddleY += 6;
          }
        }
      },
      Group {
        var startButton: Button;
        layoutX: 225
        layoutY: 470
        content: startButton = Button {
          text: "Start!"
          visible: bind startVisible
          action: function():Void {
            startVisible = false;
            pongAnimation.playFromStart();
          }
        }
      }
    ]
  }
}
// Initialize the game
initialize();
