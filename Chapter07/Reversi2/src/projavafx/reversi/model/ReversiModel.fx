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
 * ReversiModel.fx - Part of the Reversi application example that illustrates
 * dynamic layout of Nodes in a JavaFX user interface utilitizing bind,
 * boxes, and Containers.
 *
 * Developed 2009 by Stephen Chin
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.reversi.model;

import java.lang.Math;
import javafx.scene.paint.*;

/**
 * @author Stephen Chin
 */
public def BOARD_SIZE = 8;

public class Row {
  public var cells = for (i in [1..BOARD_SIZE]) Owner.NONE;
}

public class ReversiModel {
  public var turn = Owner.BLACK;

  public var board = for (i in [1..BOARD_SIZE]) Row {};

  init {
    def center1 = BOARD_SIZE / 2 - 1;
    def center2 = BOARD_SIZE / 2;
    board[center1].cells[center1] = Owner.WHITE;
    board[center1].cells[center2] = Owner.BLACK;
    board[center2].cells[center1] = Owner.BLACK;
    board[center2].cells[center2] = Owner.WHITE;
  }

  public bound function getScore(owner:Owner):Integer {
    def cells = for (row in board, cell in row.cells where cell == owner) {
      cell
    }
    return cells.size();
  }

  public function getColor(owner:Owner):Color {
    return if (owner == Owner.WHITE) then Color.WHITE else Color.BLACK;
  }

  public bound function getTurnsRemaining(owner:Owner):Integer {
    def emptyCellCount = getScore(Owner.NONE) as Number;
    return if (turn == owner) {
      Math.ceil(emptyCellCount / 2) as Integer
    } else {
      Math.floor(emptyCellCount / 2) as Integer
    }
  }
  
  public bound function legalMove(cell:Cell):Boolean {
    board[cell.y].cells[cell.x] == Owner.NONE and (
      canFlip(cell, 0, -1, turn) or
      canFlip(cell, -1, -1, turn) or
      canFlip(cell, -1, 0, turn) or
      canFlip(cell, -1, 1, turn) or
      canFlip(cell, 0, 1, turn) or
      canFlip(cell, 1, 1, turn) or
      canFlip(cell, 1, 0, turn) or
      canFlip(cell, 1, -1, turn)
    )
  }

  function canFlip(cell:Cell, xDir:Integer, yDir:Integer, turn:Owner) {
    def opposite = turn.opposite();
    var x = cell.x + xDir;
    var y = cell.y + yDir;
    if (board[y] != null and board[y].cells[x] == opposite) {
      while (board[y] != null and board[y].cells[x] == opposite) {
        x += xDir;
        y += yDir;
      }
      return board[y] != null and board[y].cells[x] == turn;
    }
    return false;
  }

  public function play(cell:Cell):Boolean {
    if (legalMove(cell)) {
      board[cell.y].cells[cell.x] = turn;
      flip(cell, 0, -1, turn);
      flip(cell, -1, -1, turn);
      flip(cell, -1, 0, turn);
      flip(cell, -1, 1, turn);
      flip(cell, 0, 1, turn);
      flip(cell, 1, 1, turn);
      flip(cell, 1, 0, turn);
      flip(cell, 1, -1, turn);
      turn = turn.opposite();
      return true;
    }
    return false;
  }

  function flip(cell:Cell, xDir:Integer, yDir:Integer, turn:Owner) {
    if (canFlip(cell, xDir, yDir, turn)) {
      def opposite = turn.opposite();
      var x = cell.x + xDir;
      var y = cell.y + yDir;
      while (board[y] != null and board[y].cells[x] == opposite) {
        board[y].cells[x] = turn;
        x += xDir;
        y += yDir;
      }
    }
  }
}
