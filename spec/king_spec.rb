require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:king) { chess.board[7][4] }

    context "when the king is moved" do

        before do
            # remove the pawns for ease of testing
            chess.board[6].map! {|pawn| pawn = nil}
            king.move_to("6 4")
            chess.update_position(king)
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "vertically he is found in the correct position" do
            expect(chess.board[6][4].symbol).to eq "♔ "
        end

        it "horizontally he is found in the correct position" do
            king.move_to("6 3")
            chess.update_position(king)
            expect(chess.board[6][3].symbol).to eq "♔ "
        end

        it "doesn't update it's position if told to move more than one space" do
            king.move_to("2 4")
            chess.update_position(king)
            expect(chess.board[6][4].symbol).to eq "♔ "
        end 

        it "doesn't update it's position if told to move around a corner" do
            king.move_to("2 7")
            chess.update_position(king)
            expect(chess.board[6][4].symbol).to eq "♔ "
        end

    end
end