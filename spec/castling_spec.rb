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
            chess.board[0][4] = King.new("b", [0,4])
            chess.board[0][0] = Rook.new("b", [0,0])
            chess.board[0][7] = Rook.new("b", [0,7])
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "allows a legal move from the white king to y2" do
            w_king.move_to('7 2')
            chess.update_position(w_king)
            expect(chess.board[7][2].symbol).to eq "♔ "
            expect(chess.board[7][3].symbol).to eq "♖ "
        end

        it "allows a legal move from the white king to y6" do
            w_king.move_to('7 6')
            chess.update_position(w_king)
            expect(chess.board[7][6].symbol).to eq "♔ "
            expect(chess.board[7][5].symbol).to eq "♖ "
        end

        it "allows a legal move from the black king to y2" do
            b_king.move_to('0 2')
            chess.update_position(b_king)
            expect(chess.board[0][2].symbol).to eq "♚ "
            expect(chess.board[0][3].symbol).to eq "♜ "
        end

        it "allows a legal move from the black king to y6" do
            b_king.move_to('0 6')
            chess.update_position(b_king)
            expect(chess.board[0][6].symbol).to eq "♚ "
            expect(chess.board[0][5].symbol).to eq "♜ "
        end

        it "doesn't allow it if the king has moved already" do
            w_king.move_to('6 4')
            chess.update_position(w_king)
            w_king.move_to('7 4')
            chess.update_position(w_king)
            w_king.move_to('7 6')
            chess.update_position(w_king)
            expect(chess.board[7][4].symbol).to eq "♔ "
        end

        it "doesn't allow it if a rook has moved already" do
            w_right.move_to('7 6')
            chess.update_position(w_right)
            w_right.move_to('7 7')
            chess.update_position(w_right)
            w_king.move_to('7 6')
            chess.update_position(w_king)
            expect(chess.board[7][7].symbol).to eq "♖ "
        end

        it "doesn't allow it if the king is in check" do
            b_right.move_to('1 7')
            chess.update_position(b_right)
            b_right.move_to('1 4')
            chess.update_position(b_right)
            w_king.move_to('7 6')
            chess.update_position(w_king)
            expect(chess.board[7][4].symbol).to eq "♔ "
        end

        it "doesn't allow it if the first pos in the king's right path is in check" do
            b_right.move_to('1 7')
            chess.update_position(b_right)
            b_right.move_to('1 5')
            chess.update_position(b_right)
            w_king.move_to('7 6')
            chess.update_position(w_king)
            expect(chess.board[7][4].symbol).to eq "♔ "
        end

        it "doesn't allow it if the second pos in the king's right path is in check" do
            b_right.move_to('1 7')
            chess.update_position(b_right)
            b_right.move_to('1 6')
            chess.update_position(b_right)
            w_king.move_to('7 6')
            chess.update_position(w_king)
            expect(chess.board[7][4].symbol).to eq "♔ "
        end

        it "doesn't allow it if the first pos in the king's left path is in check" do
            b_right.move_to('1 7')
            chess.update_position(b_right)
            b_right.move_to('1 3')
            chess.update_position(b_right)
            w_king.move_to('7 2')
            chess.update_position(w_king)
            expect(chess.board[7][4].symbol).to eq "♔ "
        end

        it "doesn't allow it if the second pos in the king's left path is in check" do
            b_right.move_to('1 7')
            chess.update_position(b_right)
            b_right.move_to('1 2')
            chess.update_position(b_right)
            w_king.move_to('7 2')
            chess.update_position(w_king)
            expect(chess.board[7][4].symbol).to eq "♔ "
        end

        it "doesn't allow it if the second pos in the black king's left path is in check" do
            w_right.move_to('6 7')
            chess.update_position(w_right)
            w_right.move_to('6 2')
            chess.update_position(w_right)
            b_king.move_to('0 2')
            chess.update_position(b_king)
            expect(chess.board[0][4].symbol).to eq "♚ "
        end

        it "allows a legal move from the white king to y6 when there is one rook" do
            chess.board[7][0] = nil
            w_king.move_to('7 6')
            chess.update_position(w_king)
            expect(chess.board[7][6].symbol).to eq "♔ "
            expect(chess.board[7][5].symbol).to eq "♖ "
        end

        it "allows a legal move from the white king to y2 when there is one rook" do
            chess.board[7][7] = nil
            w_king.move_to('7 2')
            chess.update_position(w_king)
            expect(chess.board[7][2].symbol).to eq "♔ "
            expect(chess.board[7][3].symbol).to eq "♖ "
        end
        
    end

end
