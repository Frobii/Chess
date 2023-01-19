class Piece
    attr_accessor :color, :position

    def initialize(color, position)
        @color = color
        @position = position
    end

    def move_to(new_postion)
        @position = new_position
    end
end