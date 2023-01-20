require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
    
    
    context "when the move_to method is called on a pawn" do

        it "moves the piece to the specified position" do
            expect(chess.board[5][0].symbol).to eq "♙ "
            board[6][0].move_to("5 0")
        end
        
    end

    
end