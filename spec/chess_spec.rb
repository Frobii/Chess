require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:piece) { chess.board[6][0] }
  
    context "when a pawn is moved" do

        it "allows the pawn to move forwards one positon" do
            piece.move_to("5 0")
            chess.update_position(piece)
            expect(chess.board[5][0].symbol).to eq "♙ "
        end

        it "updates the previous location to nil on the board" do
            piece.move_to("5 0")
            chess.update_position(piece)
            expect(chess.board[6][0]).to eq nil
        end

        it "doesn't allow the pawn to move forward two positions after it's first move" do
            piece.move_to("6 0")
            piece.move_to("4 0")
            chess.update_position(piece)
            expect(chess.board[4][0]).to eq nil
        end


    end

end