require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:piece) { chess.board[7][0] }

    context "when the rook is moved" do

        before do
            # remove the pawns for ease of testing
            chess.board[6].map! {|pawn| pawn = nil}
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "allows moves any length of the x axis" do
            piece.move_to("2 0")
            chess.update_position(piece)
            expect(chess.board[2][0].symbol).to eq "♖ "
        end

        it "allows moves any length of the y axis" do
            piece.move_to("2 0")
            chess.update_position(piece)
            piece.move_to("2 7")
            chess.update_position(piece)
            expect(chess.board[2][7].symbol).to eq "♖ "
        end

        it "doesn't allow diagonal moves" do
            piece.move_to("2 7")
            chess.update_position(piece)
            expect(chess.board[2][7]).to eq nil
        end

    end
    
end
