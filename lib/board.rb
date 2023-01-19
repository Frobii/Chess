class Board
    attr_accessor :board

    def initialize
        @board = Array.new(8) { Array.new(8) }
    end

    def draw_board
        board.each_with_index do |row, row_index|
            row.each_with_index do |cell, col_index| 
              if (row_index + col_index).even?
                print cell || "◾️" 
              else
                print cell || "◽️"
              end
            end
            puts
        end
    end

end

a = Board.new

a.draw_board
