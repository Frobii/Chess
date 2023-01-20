require_relative "../lib/pieces/board.rb"

describe "#move_to" do
    subject(:board) { Board.new }
    
    
    context "when the move_to method is called on a pawn" do
        
        before do
            board.setup_board
        end

        it "moves the piece to the specified position" do
            expect(board[5][0]).to eq white_pawn
            
        end
        
    end

    
end