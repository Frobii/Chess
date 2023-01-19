require_relative "./pieces/pawn.rb"

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

    def setup_board
        black_pawn = Pawn.new("b")

        board[1].map! { |cell| cell = black_pawn.symbol + " " }
    end

end

a = Board.new
a.setup_board
a.draw_board
