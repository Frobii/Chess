require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:piece) { chess.board[7][1] }

    context "when a knight is moved" do

        before do
            piece.move_to("5 2")
            chess.update_position(piece)
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "allows the knight to move forwards once and diagonal once" do
            expect(chess.board[5][2].symbol).to eq "♘ "
        end

        it "updates the previous location to nil on the board" do
            expect(chess.board[7][1]).to eq nil
        end

        it "doesn't allow it to move outside of knight travails" do
            piece.move_to("4 1")
            chess.update_position(piece)
            expect(chess.board[5][2].symbol).to eq "♘ "
        end

        it "handles consecutive moves as expected" do
            piece.move_to("4 4")
            chess.update_position(piece)
            piece.move_to("3 6")
            chess.update_position(piece)
            expect(chess.board[3][6].symbol).to eq "♘ "
        end

        it "doesn't allow it to move where another piece of the same color is" do
            piece.move_to("6 4")
            chess.update_position(piece)
            expect(chess.board[5][2].symbol).to eq "♘ "
        end

    end
end