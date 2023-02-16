require_relative "../piece.rb"

class Rook < Piece
    attr_reader :symbol
    attr_accessor :first_move

    def initialize(color, position, old_position = nil, first_move = true)
        super(color, position, old_position)
        @symbol = "♜ " if color == "b"
        @symbol = "♖ " if color == "w"
        @first_move = first_move 
    end
  
    def move_to(new_position)
        super(new_position)

        x, y = self.position[0].to_i, self.position[1].to_i
        old_x, old_y = self.old_position[0].to_i, self.old_position[1].to_i

        if x != old_x && y != old_y
            self.position = self.old_position
            self.old_position = nil
            return
        end

    end

end
