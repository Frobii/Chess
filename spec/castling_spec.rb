require_relative "../lib/board.rb"

describe "#castled?" do
    subject(:chess) { Board.new }
  
    # white pieces
    let(:w_king) { chess.board[7][4] }
    let(:w_left) { chess.board[7][0] }
    let(:w_right) { chess.board[7][7] }

    # black pieces
    let(:b_king) { chess.board[0][4] }
    let(:b_left) { chess.board[0][0] }
    let(:b_right) { chess.board[0][7] }
    

    context "when a king attempts to castle" do

        before do
            # remove the pieces for ease of testing
            chess.board[7].map! {|piece| piece = nil}
            chess.board[6].map! {|pawn| pawn = nil}
            chess.board[1].map! {|pawn| pawn = nil}
            chess.board[0].map! {|pawn| pawn = nil}
            chess.board[7][4] = King.new("w", [7,4])
            chess.board[7][0] = Rook.new("w", [7,0])
            chess.board[7][7] = Rook.new("w", [7,7])
            chess.board[0][3] = King.new("b", [0,4])
            chess.board[0][0] = Rook.new("b", [0,0])
            chess.board[0][7] = Rook.new("b", [0,7])
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "allows a legal move" do


            
        end
        
    end

end