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
            piece.move_to("5 0")
            chess.update_position(piece)
            piece.move_to("3 0")
            chess.update_position(piece)
            expect(chess.board[3][0]).to eq nil
        end

        it "doesn't allow the pawn to wrap around the board" do
            piece.move_to("4 7")
            chess.update_position(piece)
            expect(chess.board[6][0].symbol).to eq "♙ "
        end

    end

    let(:opponent_piece) { chess.board[1][1] }

    context "when a pawn is taking" do
        before do
            opponent_piece.move_to("3 1")
            chess.update_position(opponent_piece)
            piece.move_to("4 0")
            chess.update_position(piece)
        end

        it "allows a diagonal move" do
            piece.move_to("3 1")
            chess.update_position(piece)
            expect(chess.board[3][1].symbol).to eq "♙ "
        end

    end

    let(:blocking_piece) { chess.board[1][0] }

    context "when a pawn is in front of another pawn" do
        before do 
            blocking_piece.move_to("3 0")
            chess.update_position(blocking_piece)
            piece.move_to("4 0")
            chess.update_position(piece)
        end

        it "cannot take the other pawn" do
            piece.move_to("3 0")
            chess.update_position(piece)
            expect(chess.board[3][0].symbol).to eq "♟︎ "
        end
        
    end

end
