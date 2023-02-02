require_relative "../lib/board.rb"

describe "#check?" do
    subject(:chess) { Board.new }
  
    # white pieces
    let(:king) { chess.board[7][4] }

    # black pieces
    let(:l_rook) { chess.board[0][0] }
    let(:l_knight) { chess.board[0][1] }
    let(:l_bishop) { chess.board[0][2] }
    let(:black_queen) { chess.board[0][4] }
    let(:black_king) { chess.board[0][3] }
    let(:r_bishop) { chess.board[0][5] }
    let(:r_knight) { chess.board[0][6] }
    let(:r_rook) { chess.board[0][7] }
    

    context "when a piece's move exposes the king to check" do

        before do
            # remove the pieces for ease of testing
            chess.board[7].map! {|piece| piece = nil}
            chess.board[6].map! {|pawn| pawn = nil}
            chess.board[1].map! {|pawn| pawn = nil}
            chess.board[3][3] = Pawn.new("b", [4,3])
            chess.board[4][4] = Pawn.new("w", [5,4])
            chess.board[7][5] = Bishop.new("w", [7,5])
            chess.board[7][4] = King.new("w", [7,4])
        end

        after do
            puts "\n"
            chess.draw_board
        end

        let(:bishop) { chess.board[7][5] }

        it "returns true when a king is pinned by rooks" do
            l_rook.move_to('6 0')
            chess.update_position(l_rook)
            r_rook.move_to('7 7')
            chess.update_position(r_rook)
            bishop.move_to('5 7')
            chess.update_position(bishop)
            expect(chess.check?(king)).to be(false)
        end

    end

end