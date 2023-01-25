require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:piece) { chess.board[7][0] }

    context "when the rook is moved" do

        before do
            # remove the pawns for ease of testing
            chess.board[6].map! {|pawn| pawn = nil}
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "allows moves any length of the x axis" do
            piece.move_to("2 0")
            chess.update_position(piece)
            expect(chess.board[2][0].symbol).to eq "♖ "
        end

        it "allows moves any length of the y axis" do
            piece.move_to("2 0")
            chess.update_position(piece)
            piece.move_to("2 7")
            chess.update_position(piece)
            expect(chess.board[2][7].symbol).to eq "♖ "
        end

        it "doesn't allow diagonal moves" do
            piece.move_to("2 7")
            chess.update_position(piece)
            expect(chess.board[2][7]).to eq nil
        end

        it "doesn't allow it to take pieces of the same suit" do
            piece.move_to("7 1")
            chess.update_position(piece)
            expect(chess.board[7][0].symbol).to eq "♖ "
        end

        it "allows the rook to take pieces of the opposite suit" do
            piece.move_to("1 0")
            chess.update_position(piece)
            expect(chess.board[1][0].symbol).to eq "♖ "
        end

        it "can't pass if another piece is in it's way" do
            piece.move_to("0 0")
            chess.update_position(piece)
            expect(chess.board[7][0].symbol).to eq "♖ "
        end

        let(:knight) { chess.board[7][1] }

        it "works the other way round" do
            piece.move_to("2 0")
            chess.update_position(piece)
            knight.move_to("5 0")
            chess.update_position(knight)
            # invalid move below
            piece.move_to("7 0")
            chess.update_position(piece)
            expect(chess.board[2][0].symbol).to eq "♖ "
        end

    end
    
end
