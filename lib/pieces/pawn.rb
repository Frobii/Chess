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
        
        x, y = self.position[0].to_i, self.position[1].to_i
        old_x, old_y = self.old_position[0].to_i, self.old_position[1].to_i

        # checks if a taking move is legal
        if y != old_y
            if self.color == "w" && (old_x - x) != 1
                self.position = self.old_position
                self.old_position = nil
            end 
            
            if self.color == "b" && (x - old_x) != 1
                self.position = self.old_position
                self.old_position = nil
            end    
        end

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
