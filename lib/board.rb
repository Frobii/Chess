require_relative "./pieces/pawn.rb"
require_relative "./pieces/queen.rb"
require_relative "./pieces/king.rb"
require_relative "./pieces/rook.rb"
require_relative "./pieces/knight.rb"
require_relative "./pieces/bishop.rb"
require_relative "./check.rb"
require_relative "./game.rb"

class Board
  include Check_Rules
  include Play_Game
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    setup_board
  end

  def draw_board
    # add column numbers
    print "  "
    (0..7).each { |i| print "#{i} " }
    puts
  
    board.each_with_index do |row, row_index|
      # add row number
      print "#{row_index} "
      row.each_with_index do |cell, col_index| 
        if (row_index + col_index).even?
          if cell.nil?
            print "◽️"
          else
            print cell.symbol
          end
        else
          if cell.nil?
            print "◾️"
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
    board[0][3] = Queen.new("b", [0,3])
    board[7][3] = Queen.new("w", [7,3])

    # setup the kings
    board[0][4] = King.new("b", [0,4])
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
    
    # return if an invalid move is made, the old_position should be nil
    return if piece.old_position.nil?

    return if king_in_danger?(piece)
    
    return if invalid_take?(piece)
    
    return if check?(piece)

    # the castled method handles it's own movement
    return if castled?(piece)
    
    old_x, old_y = piece.old_position[0].to_i, piece.old_position[1].to_i
    x, y = piece.position[0].to_i, piece.position[1].to_i

    # places the piece where the user decided to make a move & nil where the piece used to be
    board[old_x][old_y] = nil
    board[x][y] = piece

    piece.first_move = false if piece.is_a?(Rook) || piece.is_a?(King)

    upgrade_pawn(piece, x, y) if pawn_upgradable?(piece, x, y) 
    
  end

  def pawn_upgradable?(piece, x, y)
    return false if !piece.is_a?(Pawn)
    
    if piece.color == "w"
      return false if x != 0
    elsif piece.color == "b"
      return false if x != 7
    end

    true

  end

  def upgrade_pawn(piece, x, y)
    puts "Select your upgrade..."
    puts "1: Queen, 2: Rook, 3: Knight, 4: Bishop"

    input = gets.chomp.to_i until input.is_a?(Integer) && input.between?(1, 4)

    board[x][y] = Queen.new(piece.color, [x, y]) if input == 1
    board[x][y] = Rook.new(piece.color, [x, y]) if input == 2
    board[x][y] = Knight.new(piece.color, [x, y]) if input == 3
    board[x][y] = Bishop.new(piece.color, [x, y]) if input == 4

  end

  def castled?(piece)
    return false unless piece.is_a?(King)

    x, y = piece.position[0].to_i, piece.position[1].to_i
    old_x, old_y = piece.old_position[0].to_i, piece.old_position[1].to_i

    # return when the king is making a regular move 
    return false if y != 2 && y != 6
    
    rooks = board.flatten.select { |p| p.is_a?(Rook) && p.color == piece.color }

    if rooks.length >= 2
      l_rook = rooks[0]
      r_rook = rooks[1]
    else
      l_rook = rooks[0] if rooks[0].position[1].to_i == 0
      r_rook = rooks[0] if rooks[0].position[1].to_i == 7
    end

    # set the pos to old_pos before check? due to the way check handles positions
    save_pos = piece.position
    piece.position = piece.old_position

    return true if check?(piece)
    
    # revert the king's position back
    piece.position = save_pos

    # check the positions along the kings path for check
    return true if castle_check?(piece)
    
    # exit the execution if the relevant rook has moved
    if y == 2 
     return true if l_rook.first_move == false

     # while the y value is checked, update the relevant rooks position/old position
     l_rook.old_position = l_rook.position
     l_rook.position = [7,3] if piece.color == "w"
     l_rook.position = [0,3] if piece.color == "b"

    elsif y == 6
     return true if r_rook.first_move == false

     r_rook.old_position = r_rook.position
     r_rook.position = [7,5] if piece.color == "w"
     r_rook.position = [0,5] if piece.color == "b"
     
    end

    # update the kings position before reassigning x and y values for the rook
    board[x][y] = piece
    board[old_x][old_y] = nil
    piece.first_move = false

    if y == 2
      x, y = l_rook.position[0].to_i, l_rook.position[1].to_i
      old_x, old_y = l_rook.old_position[0].to_i, l_rook.old_position[1].to_i

      board[x][y] = rooks[0]
      board[old_x][old_y] = nil

      l_rook.first_move = false

    elsif y == 6
      x, y = r_rook.position[0].to_i, r_rook.position[1].to_i
      old_x, old_y = r_rook.old_position[0].to_i, r_rook.old_position[1].to_i

      board[x][y] = r_rook
      board[old_x][old_y] = nil

      r_rook.first_move = false

    end

    true

  end

  def castle_check?(piece)
    x, y = piece.position[0].to_i, piece.position[1].to_i
    old_x, old_y = piece.old_position[0].to_i, piece.old_position[1].to_i

    if y == 6
      directions = [0, 1], [0, 2]
    elsif y == 2
      directions = [0, -1], [0, -2]
    end

    directions.each do |dx, dy|
      i, j = old_x + dx, old_y + dy

      in_check = check?(nil, i, j, piece.color)

      return true if in_check
    end

    false
      
  end

  def king_in_danger?(piece)
    king = board.flatten.select { |p| p.is_a?(King) && p.color == piece.color }.first

    # return false when there are no kings (used for tests)
    return false if king == nil

    x, y = piece.position[0].to_i, piece.position[1].to_i
    old_x, old_y = piece.old_position[0].to_i, piece.old_position[1].to_i

    # save the state of the potential position
    dont_update = board[x][y]

    # temporarily update the pieces position
    board[x][y] = piece
    board[old_x][old_y] = nil

    # see if the move put the king in check
    danger = check?(king)
    
    # reset the pieces positon
    board[old_x][old_y] = piece
    board[x][y] = dont_update

    return danger
  end

  def invalid_take?(piece)
    # gather the coordinates of the pieces target and old position
    x, y = piece.position[0].to_i, piece.position[1].to_i
    old_x, old_y = piece.old_position[0].to_i, piece.old_position[1].to_i

    # check if there's an attempt to take a piece of the same color
    if !board[x][y].nil?
      if board[x][y].color == piece.color
        return true
      end
    end

    # everything that moves either on the x or y axis, not diagonally
    if piece.is_a?(Rook) || piece.is_a?(Queen)
      
      # exclude the queens diagonal movments
      if old_x == x || old_y == y
        # ensure a target piece can't be taken if there is another piece in it's way
        if old_x > x
          # take and add one to exclude the piece and target from the equation
          ((x + 1)..(old_x - 1)).each do |col|
            # check each piece between the two to see if there is a blockage
            return true if !board[col][y].nil?
          end
          
        end
        
        if old_x < x
          # take and add one to exclude the piece and target from the equation
          ((old_x + 1)..(x - 1)).each do |col|
            # check each piece between the two to see if there is a blockage
            return true if !board[col][y].nil?
          end
          
        end
        
        if old_y > y
          ((y + 1)..(old_y - 1)).each do |row|
            return true if !board[x][row].nil?
          end
        end
        
        if old_y < y
          ((old_y + 1)..(y - 1)).each do |row|
            return true if !board[x][row].nil?
          end
        end
      end
      
    end

    if piece.is_a?(Bishop) || piece.is_a?(Queen)

      # bottom right to top left
      if old_x > x && old_y > y
        ((old_x - 1).downto(x + 1)).each_with_index do |col, i|
          row = old_y - i - 1
          return true if !board[col][row].nil?
        end
      end
    
      # top left to bottom right
      if old_x < x && old_y < y
        ((old_x + 1)..(x - 1)).each_with_index do |col, i|
          row = old_y + i + 1
          return true if !board[col][row].nil?
        end
      end

      # top right to bottom left
      if old_x < x && old_y > y
        ((old_x + 1)..(x - 1)).each_with_index do |col, i|
          row = old_y - i - 1
          return true if !board[col][row].nil?
        end
      end

      # bottom left to top right
      if old_x > x && old_y < y
        ((old_x - 1).downto(x + 1)).each_with_index do |col, i|
          p col
          row = old_y + i + 1
          p row
          return true if !board[col][row].nil?
        end
      end
      
    end
    
    if piece.is_a?(Pawn)
      
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
