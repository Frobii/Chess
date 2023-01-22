require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:piece) { chess.board[6][0] }
    
    def move_piece
        piece.move_to("5 0")
        chess.update_position(piece)
    end
  
    context "when the move_to method is called on a pawn" do
  
        before { move_piece }

        it "moves the piece to the specified position" do
        expect(chess.board[5][0].symbol).to eq "♙ "
        end

        it "updates the previous location to nil on the board" do
        expect(chess.board[6][0]).to eq nil
        end

    end
end