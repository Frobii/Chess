require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:piece) { chess.board[7][2] }

    context "when the bishop is moved" do

        before do
            # remove the pawns for ease of testing
            chess.board[6].map! {|pawn| pawn = nil}
            piece.move_to("3 6")
            chess.update_position(piece)
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "can travel diagonally" do
            expect(chess.board[3][6].symbol).to eq "♗ "
        end

        it "can't travel along just it's x axis" do
            piece.move_to("4 6")
            chess.update_position(piece)
            expect(chess.board[3][6].symbol).to eq "♗ "
        end

        it "can't travel along just it's y axis" do
            piece.move_to("3 7")
            chess.update_position(piece)
            expect(chess.board[3][6].symbol).to eq "♗ "
        end

        it "can take an opponents piece" do

            piece.move_to("1 4")
            chess.update_position(piece)
            expect(chess.board[1][4].symbol).to eq "♗ "
            
        end

        it "can't take an opponents piece through another piece" do

            piece.move_to("0 3")
            chess.update_position(piece)
            expect(chess.board[3][6].symbol).to eq "♗ "
            
        end

        let (:friendly_rook) { chess.board[7][7] }

        it "can't take a friendly piece" do
            friendly_rook.move_to("2 7")
            chess.update_position(friendly_rook)
            piece.move_to("2 7")
            chess.update_position(piece)
            expect(chess.board[3][6].symbol).to eq "♗ "
            
        end

        let (:friendly_knight) { chess.board[7][6]}

        it "can't move through a friendly piece" do
            # setup the knight
            friendly_knight.move_to("5 5")
            chess.update_position(friendly_rook)
            friendly_knight.move_to("6 3")
            chess.update_position(friendly_knight)
            # attempt to pass through the knight
            piece.move_to("7 2")
            chess.update_position(piece)
            # check if the bishop stayed put
            expect(chess.board[3][6].symbol).to eq "♗ "
        end

        it "can't move around corners" do
            piece.move_to("5 5")
            chess.update_position(piece)
            expect(chess.board[3][6].symbol).to eq "♗ "
        end


    end
end