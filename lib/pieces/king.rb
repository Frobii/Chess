require_relative "../piece.rb"

class King < Piece
    attr_reader :symbol

    def initialize(color, position)
        super(color, position)
        @symbol = "♚ " if color == "b"
        @symbol = "♔ " if color == "w"
    end

    def move_to(new_position)

        

        super
    end

end