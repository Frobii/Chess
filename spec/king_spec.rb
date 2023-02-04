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

        let (:enemy_pawn) {chess.board[1][6]}
        let (:enemy_bishop) {chess.board[0][5]}

        it "can move if an enemy piece is blocking the check piece" do
            enemy_pawn.move_to("3 6")
            chess.update_position(enemy_pawn)
            enemy_bishop.move_to("2 7")
            chess.update_position(enemy_bishop)
            king.move_to("5 4")
            chess.update_position(king)
            expect(chess.board[5][4].symbol).to eq "♔ "
        end
        
        it "can't move to a check position from a diagonal taker to the right" do
            enemy_pawn.move_to("2 6")
            chess.update_position(enemy_pawn)
            enemy_bishop.move_to("2 7")
            chess.update_position(enemy_bishop)
            king.move_to("5 4")
            chess.update_position(king)
            expect(chess.board[6][4].symbol).to eq "♔ "
        end

        let (:left_enemy_pawn) {chess.board[1][3]}
        let (:left_enemy_bishop) {chess.board[0][2]}

        it "can't move to a check position from a diagonal taker to the left" do
            left_enemy_pawn.move_to("2 3")
            chess.update_position(left_enemy_pawn)
            left_enemy_bishop.move_to("3 5")
            chess.update_position(left_enemy_bishop)
            king.move_to("5 4")
            chess.update_position(king)
            king.move_to("4 4")
            chess.update_position(king)
            expect(chess.board[5][4].symbol).to eq "♔ "
        end

        let (:enemy_queen) {chess.board[0][3]}

        it "can't move to a check position from a vertical taker" do
            left_enemy_pawn.move_to("2 3")
            chess.update_position(left_enemy_pawn)
            enemy_queen.move_to("1 3")
            chess.update_position(enemy_queen)
            enemy_queen.move_to("2 2")
            chess.update_position(enemy_queen)
            enemy_queen.move_to("3 3")
            chess.update_position(enemy_queen)
            king.move_to("5 3")
            chess.update_position(king)
            expect(chess.board[6][4].symbol).to eq "♔ "
        end

        it "can't move to a check position from a horizontal taker" do
            left_enemy_pawn.move_to("2 3")
            chess.update_position(left_enemy_pawn)
            enemy_queen.move_to("1 3")
            chess.update_position(enemy_queen)
            enemy_queen.move_to("3 1")
            chess.update_position(enemy_queen)
            king.move_to("5 4")
            chess.update_position(king)
            king.move_to("4 4")
            chess.update_position(king)
            king.move_to("3 3")
            chess.update_position(king)
            expect(chess.board[4][4].symbol).to eq "♔ "
        end

        it "can't move to a check position from a pawn taker" do
            left_enemy_pawn.move_to("3 3")
            chess.update_position(left_enemy_pawn)
            left_enemy_pawn.move_to("4 3")
            chess.update_position(left_enemy_pawn)
            king.move_to("5 4")
            chess.update_position(king)
            expect(chess.board[6][4].symbol).to eq "♔ "
        end

        let (:enemy_knight) {chess.board[0][6]}

        it "can't move to a check position from a knight taker" do
            enemy_knight.move_to("2 5")
            chess.update_position(enemy_knight)
            enemy_knight.move_to("4 6")
            chess.update_position(enemy_knight)
            king.move_to("5 4")
            chess.update_position(king)
            expect(chess.board[6][4].symbol).to eq "♔ "
        end

        let (:black_king_pawn) {chess.board[1][4]}
        let (:black_king) {chess.board[0][4]}

        it "doesn't allow kings to enter each other's vicinity" do
            black_king_pawn.move_to("3 4")
            chess.update_position(black_king_pawn)
            black_king.move_to("1 4")
            chess.update_position(black_king)
            # black_king.move_to("2 4")
            # chess.update_position(black_king)
            # black_king.move_to("3 4")
            # chess.update_position(black_king)
            # black_king.move_to("4 4")
            # chess.update_position(black_king)
            # black_king.move_to("5 4")
            chess.update_position(black_king)
            expect(chess.board[4][4].symbol).to eq "♚ "
        end

    end
end
