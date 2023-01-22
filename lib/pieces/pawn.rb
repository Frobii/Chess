require_relative "../piece.rb"

class Pawn < Piece
    attr_reader :symbol

    def initialize(color, position, old_position = nil)
        super(color, position, old_position)
        @symbol = "♟︎ " if color == "b"
        @symbol = "♙ " if color == "w"
    end

    def move_to(new_position)
        super(new_position)

        # status: currently working on the logic for illegal pawn moves
        new_pos_array = new_position.split(" ")
        x, y = new_pos_array[0].to_i, new_pos_array[1].to_i
        
        # if old_position.nil?
        #     if 

    end

end
