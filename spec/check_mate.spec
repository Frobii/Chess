require_relative "../lib/board.rb"

describe "#check_mate?" do
    subject(:chess) { Board.new }
  
    # white pieces
    let(:king) { chess.board[7][4] }
    let(:bishop) { chess.board[6][6] }

    # black pieces
    let(:l_rook) { chess.board[0][0] }
    let(:l_knight) { chess.board[0][1] }
    let(:l_bishop) { chess.board[0][2] }
    let(:black_queen) { chess.board[0][3] }
    let(:black_king) { chess.board[0][4] }
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
            chess.board[6][6] = Bishop.new("w", [6,6])
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "returns true when a king is pinned by rooks" do
            chess.board[6][6] = nil
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
            black_queen.move_to('1 3')
            chess.update_position(black_queen)
            black_queen.move_to('4 6')
            chess.update_position(black_queen)
            black_queen.move_to('6 4')
            chess.update_position(black_queen)
            expect(chess.check_mate?(king)).to be(true)
        end

        it "returns false when a king can take an attacking queen" do
            black_queen.move_to('1 3')
            chess.update_position(black_queen)
            black_queen.move_to('4 6')
            chess.update_position(black_queen)
            black_queen.move_to('6 4')
            chess.update_position(black_queen)
            expect(chess.check_mate?(king)).to be(false)
        end

        it "returns false if a friendly piece can take to get out of check" do
            l_rook.move_to('6 0')
            chess.update_position(l_rook)
            r_rook.move_to('7 7')
            chess.update_position(r_rook)
            expect(chess.check_mate?(king)).to be(false)
        end

        it "doesn't allow a defender to do anything but defend a check" do
            l_rook.move_to('6 0')
            chess.update_position(l_rook)
            r_rook.move_to('7 7')
            chess.update_position(r_rook)
            bishop.move_to('5 5')
            chess.update_position(bishop)
            expect(chess.board[6][6].symbol).to eq "♗ "
        end

        it "does allow a defender to take the attacking piece" do
            l_rook.move_to('6 0')
            chess.update_position(l_rook)
            r_rook.move_to('7 7')
            chess.update_position(r_rook)
            bishop.move_to('7 7')
            chess.update_position(bishop)
            expect(chess.board[7][7].symbol).to eq "♗ "
        end

    end

end
