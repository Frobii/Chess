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
    setup_board
  end

  def draw_board
    board.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index| 
          if (row_index + col_index).even?
            if cell.nil?
              print "◾️"
            else
              print cell.symbol
            end
          else
            if cell.nil?
              print "◽️"
            else
              print cell.symbol
            end
          end
        end
        puts
    end
  end

  def setup_board

    # setup the pawns
    (0..7).each do |col|
      board[1][col] = Pawn.new('b', [1, col])
      board[6][col] = Pawn.new('w', [6, col])
    end

    # setup the queens
    board[0][4] = Queen.new("b", [0,4])
    board[7][3] = Queen.new("w", [7,3])

    # setup the kings
    board[0][3] = King.new("b", [0,3])
    board[7][4] = King.new("w", [7,4])

    # setup the rooks
    board[0][0], board[0][7] = Rook.new("b", [0,0]), Rook.new("b", [0,7])
    board[7][0], board[7][7] = Rook.new("w", [7,0]), Rook.new("w", [7,7])

    # setup the knights
    board[0][1], board[0][6] = Knight.new("b", [0,1]), Knight.new("b", [0,6])
    board[7][1], board[7][6] = Knight.new("w", [7,1]), Knight.new("w", [7,6])

    # setup the bishops
    board[0][2], board[0][5] = Bishop.new("b", [0,2]), Bishop.new("b", [0,5])
    board[7][2], board[7][5] = Bishop.new("w", [7,2]), Bishop.new("w", [7,5])

  end

  def update_position(piece)
    
    # if an invalid move is made the old_position is made nil
    return if piece.old_position.nil?

    return if invalid_take?(piece)
    
    # places nil where the piece used to be
    x, y = piece.old_position[0].to_i, piece.old_position[1].to_i
    board[x][y] = nil

    # places the piece where the user decided to make a move
    x, y = piece.position[0].to_i, piece.position[1].to_i
    board[x][y] = piece
    
  end

  def invalid_take?(piece)
    # gather the coordinates of the pieces take
    x, y = piece.position[0].to_i, piece.position[1].to_i
    old_x, old_y = piece.old_position[0].to_i, piece.old_position[1].to_i

    # check if there's an attempt to take a piece of the same color
    if !board[x][y].nil?
      if board[x][y].color == piece.color
        return true
      end
    end

    # everything that moves either on the x or y axis, not diagonally
    if !(piece.symbol == "♞ ") && !(piece.symbol == "♘ ")

      # ensure a target piece can't be taken if there is another piece in it's way

      if old_x > x
        # take and add one to exclude the piece and target from the equation
        ((x + 1)..(old_x - 1)).each do |col|
          # check each piece between the two to see if there is a blockage
          return !board[col][y].nil? if !board[col][y].nil?

        end

      end

      if old_x < x
        # take and add one to exclude the piece and target from the equation
        ((old_x + 1)..(x - 1)).each do |col|
          # check each piece between the two to see if there is a blockage
          return !board[col][y].nil? if !board[col][y].nil?

        end

      end

      if old_y > y
        ((y + 1)..(old_y - 1)).each do |row|
          return !board[x][row].nil? if !board[x][row].nil?
        end
      end

      if old_y < y
        ((old_y + 1)..(y - 1)).each do |row|
          return !board[x][row].nil? if !board[x][row].nil?
        end
      end

    end
    
    # pawn
    if piece.symbol == "♟︎ " || piece.symbol == "♙ "

      # ensures a pawn is making a taking move
      if y != old_y
        # verify if a piece is where a pawn is taking
        return board[x][y].nil?
      end

      # ensure a pawn can't take from in front of it
      if y == old_y
        return !board[x][y].nil?
      end

    end

    false

  end

end
