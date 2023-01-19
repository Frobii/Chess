require_relative "../piece.rb"

class Pawn < Piece
    attr_reader :symbol

    def initialize(color)
        @symbol = "♟︎" if color == "b"
        @symbol = "♙" if color == "w"
    end

end
