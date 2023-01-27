require_relative "../piece.rb"

class King < Piece
    attr_reader :symbol

    def initialize(color, position, old_position = nil)
        super(color, position, old_position)
        @symbol = "♚ " if color == "b"
        @symbol = "♔ " if color == "w"
    end

    def move_to(new_position)
        super(new_position)

        x, y = self.position[0].to_i, self.position[1].to_i
        old_x, old_y = self.old_position[0].to_i, self.old_position[1].to_i

        # reset moves which attempt to move the king outside of it's immediate vicinity
        if old_x > x
            if (old_x - x) > 1
                self.position = self.old_position
                self.old_position = nil
            end
        elsif x > old_x
            if (x - old_x) > 1
                self.position = self.old_position
                self.old_position = nil
            end
        elsif old_y > y
            if (old_y - y) > 1
                self.position = self.old_position
                self.old_position = nil
            end
        elsif y > old_y
            if (y - old_y) > 1
                self.position = self.old_position
                self.old_position = nil
            end
        end

    end

end