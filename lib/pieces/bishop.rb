require_relative "../piece.rb"

class Bishop < Piece
    attr_reader :symbol

    def initialize(color)
        @symbol = "♝ " if color == "b"
        @symbol = "♗ " if color == "w"
    end

    def move_to

        

        super
    end

end
