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
        # ISSUE: THE BOARD DOESN'T REMOVE THE OLD PAWN
        
        x = self.position[0].to_i
        old_x = self.old_position[0].to_i #if !self.old_position.nil?

        # resets the position if an illegal pawn move is made
        if self.color == "w"
            if old_x != 6 && x != 4
                if (old_x - x) != 1
                    self.position = self.old_position
                    self.old_position = nil
                end
            end
        end

        if self.color == "b"
            if old_x != 1 && x != 3
                if (x - old_x) != 1
                    self.position = self.old_position
                    self.old_position = nil
                end
            end
        end

    end

end
