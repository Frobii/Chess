require_relative "../piece.rb"

class Bishop < Piece
    attr_reader :symbol

    def initialize(color, position, old_position = nil)
        super(color, position, old_position)
        @symbol = "♝ " if color == "b"
        @symbol = "♗ " if color == "w"
    end

    def move_to(new_position)
        super(new_position)

        x, y = self.position[0].to_i, self.position[1].to_i
        old_x, old_y = self.old_position[0].to_i, self.old_position[1].to_i

        # reset the knights position if both of it's axis don't change
        if x == old_x || y == old_y
            self.position = self.old_position
            self.old_position = nil
        end

        # reset the knights position if it tries to travel "around a corner"
        # check every possible coordinate combo to verify diagonal movement
        if old_x > x
            if old_y > y
                if (old_x - x) != (old_y - y)
                    self.position = self.old_position
                    self.old_position = nil
                end
            else
                if (old_x - x) != (y - old_y)
                    self.position = self.old_position
                    self.old_position = nil
                end
            end
        else
            if old_y > y
                if (x - old_x) != (old_y - y)
                    self.position = self.old_position
                    self.old_position = nil
                end
            else
                if (x - old_x) != (y - old_y)
                    self.position = self.old_position
                    self.old_position = nil
                end
            end
        end

    end

end
