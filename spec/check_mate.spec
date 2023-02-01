require_relative "../lib/board.rb"

describe "#check_mate?" do
    subject(:chess) { Board.new }
  
    let(:king) { chess.board[7][4] }
    let(:l_rook) { chess.board[0][0] }
    let(:l_knight) { chess.board[0][1] }
    let(:l_bishop) { chess.board[0][2] }
    let(:black_queen) { chess.board[0][4] }
    let(:black_king) { chess.board[0][3] }
    let(:r_bishop) { chess.board[0][5] }
    let(:r_knight) { chess.board[0][6] }
    let(:r_rook) { chess.board[0][7] }
    

    context "when the king is in check_mate" do

        before do
            # remove the pieces for ease of testing
            chess.board[7].map! {|piece| piece = nil}
            chess.board[6].map! {|pawn| pawn = nil}
            chess.board[1].map! {|pawn| pawn = nil}
            chess.board[3][3] = Pawn.new("b", [4,3])
            chess.board[4][4] = Pawn.new("w", [5,4])
            chess.board[7][4] = King.new("w", [7,4])
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "returns true when a king is pinned by rooks" do
            l_rook.move_to('6 0')
            chess.update_position(l_rook)
            r_rook.move_to('7 7')
            chess.update_position(r_rook)
            expect(chess.check_mate?(king)).to be(true)
        end

        it "returns false when a king is not in checkmate" do
            l_rook.move_to('6 0')
            chess.update_position(l_rook)
            expect(chess.check_mate?(king)).to be(false)
        end

        it "returns true when a king is pinned by a queen" do
            l_rook.move_to('6 0')
            chess.update_position(l_rook)
            black_queen.move_to('3 7')
            chess.update_position(black_queen)
            black_queen.move_to('6 4')
            chess.update_position(black_queen)
            expect(chess.check_mate?(king)).to be(true)
        end

        it "returns false when a king can take an attacking queen" do
            black_queen.move_to('3 7')
            chess.update_position(black_queen)
            black_queen.move_to('6 4')
            chess.update_position(black_queen)
            expect(chess.check_mate?(king)).to be(false)
        end

    end

end
