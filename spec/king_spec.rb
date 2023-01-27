require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:king) { chess.board[7][4] }

    context "when the king is moved" do

        before do
            # remove the pawns for ease of testing
            chess.board[6].map! {|pawn| pawn = nil}
            king.move_to("6 4")
            chess.update_position(king)
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "vertically he is found in the correct position" do
            expect(chess.board[6][4].symbol).to eq "♔ "
        end

        it "horizontally he is found in the correct position" do
            king.move_to("6 3")
            chess.update_position(king)
            expect(chess.board[6][3].symbol).to eq "♔ "
        end

        it "doesn't update it's position if told to move more than one space" do
            king.move_to("2 4")
            chess.update_position(king)
            expect(chess.board[6][4].symbol).to eq "♔ "
        end 

        it "doesn't update it's position if told to move around a corner" do
            king.move_to("2 7")
            chess.update_position(king)
            expect(chess.board[6][4].symbol).to eq "♔ "
        end

        it "can't take a friendly piece" do
            king.move_to("7 3")
            chess.update_position(king)
            expect(chess.board[6][4].symbol).to eq "♔ "
        end

        let (:enemy_knight) {chess.board[0][6]}

        it "can take an enemy piece" do
            enemy_knight.move_to("2 5")
            chess.update_position(enemy_knight)
            enemy_knight.move_to("4 6")
            chess.update_position(enemy_knight)
            enemy_knight.move_to("6 5")
            chess.update_position(enemy_knight)
            king.move_to("6 5")
            chess.update_position(king)
            expect(chess.board[6][5].symbol).to eq "♔ "
        end

        let (:enemy_pawn) {chess.board[1][5]}

        it "can't move to a check position" do
            enemy_pawn.move_to("3 5")
            chess.update_position(enemy_pawn)
            king.move_to("5 4")
            chess.update_position(king)
            king.move_to("4 4")
            chess.update_position(king)
            expect(chess.board[5][4].symbol).to eq "♔ "
        end

    end
end