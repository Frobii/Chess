require_relative "./pieces/pawn.rb"
require_relative "./pieces/queen.rb"
require_relative "./pieces/king.rb"
require_relative "./pieces/rook.rb"
require_relative "./pieces/knight.rb"
require_relative "./pieces/bishop.rb"

class Board
  attr_accessor :board

  def initialize
      @board = Array.new(8) { Array.new(8) }
  end

  def draw_board
      board.each_with_index do |row, row_index|
          row.each_with_index do |cell, col_index| 
            if (row_index + col_index).even?
              print cell || "◾️" 
            else
              print cell || "◽️"
            end
          end
          puts
      end
  end

  def setup_board
    black_pawn = Pawn.new("b")
    black_queen = Queen.new("b")
    black_king = King.new("b")
    black_rook = Rook.new("b")
    black_knight = Knight.new("b")
    black_bishop = Bishop.new("b")

    white_pawn = Pawn.new("w")
    white_queen = Queen.new("w")
    white_king = King.new("w")
    white_rook = Rook.new("w")
    white_knight = Knight.new("w")
    white_bishop = Bishop.new("w")
    
    # setup the pawns
    board[1].map! { |cell| cell = black_pawn.symbol }
    board.reverse[1].map!{ |cell| cell = white_pawn.symbol }

    # setup the queens
    board[0][4] = black_queen.symbol
    board.reverse[0][3] = white_queen.symbol

    # setup the kings
    board[0][3] = black_king.symbol
    board.reverse[0][4] = white_king.symbol

    # setup the rooks
    board[0][0], board[0][7] = black_rook.symbol , black_rook.symbol
    board.reverse[0][0], board.reverse[0][7] = white_rook.symbol , white_rook.symbol

    # setup the knights
    board[0][1], board[0][6] = black_knight.symbol , black_knight.symbol
    board.reverse[0][1], board.reverse[0][6] = white_knight.symbol , white_knight.symbol

    # setup the bishops
    board[0][2], board[0][5] = black_bishop.symbol, black_bishop.symbol
    board.reverse[0][2], board.reverse[0][5] = white_bishop.symbol, white_bishop.symbol

  end

end

a = Board.new
a.setup_board
a.draw_board
