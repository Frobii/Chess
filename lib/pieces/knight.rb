require_relative "../piece.rb"

class Knight < Piece
    attr_reader :symbol

    def initialize(color, position, old_position = nil)
        super(color, position, old_position)
        @symbol = "♞ " if color == "b"
        @symbol = "♘ " if color == "w"
    end

    def move_to(new_position)
        super(new_position)

        x, y = self.position[0].to_i, self.position[1].to_i
        old_x, old_y = self.old_position[0].to_i, self.old_position[1].to_i

        moves = [[1, 2], [2, 1], [-1, 2], [-2, 1], [1, -2], [2, -1], [-1, -2], [-2, -1]]

        move_made = [x - old_x, y - old_y]

        moves.each_with_index do |valid_move, index| 
            if move_made == valid_move
                return
            end

            # reset the attempted move when a valid move isn't found
            if index == 7
                self.position = self.old_position
                self.old_position = nil
            end
        end

    end

end
