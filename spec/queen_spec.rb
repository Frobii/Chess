require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:queen) { chess.board[7][3] }

    context "when the queen is moved" do

        before do
            # remove the pawns for ease of testing
            chess.board[6].map! {|pawn| pawn = nil}
            queen.move_to("4 6")
            chess.update_position(queen)
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "travels diagonally" do
            expect(chess.board[4][6].symbol).to eq "♕ "
        end

        it "travels vertically" do
            queen.move_to("6 6")
            chess.update_position(queen)
            expect(chess.board[6][6].symbol).to eq "♕ "
        end

        it "travels horizontally" do
            queen.move_to("4 1")
            chess.update_position(queen)
            expect(chess.board[4][1].symbol).to eq "♕ "
        end

        it "can't move around corners" do
            queen.move_to("6 5")
            chess.update_position(queen)
            expect(chess.board[4][6].symbol).to eq "♕ "
        end

        it "cannot take a friendly piece" do
            queen.move_to("7 6")
            chess.update_position(queen)
            expect(chess.board[4][6].symbol).to eq "♕ "
        end

        it "can take an enemy piece" do
            queen.move_to("1 6")
            chess.update_position(queen)
            expect(chess.board[1][6].symbol).to eq "♕ "
        end

        it "can't take an enemy piece if blocked" do
            queen.move_to("0 6")
            chess.update_position(queen)
            expect(chess.board[4][6].symbol).to eq "♕ "
        end

        it "can't take an enemy piece if blocked diagonally" do
            queen.move_to("0 2")
            chess.update_position(queen)
            expect(chess.board[4][6].symbol).to eq "♕ "
        end

        let (:knight) {chess.board[7][6]}

        it "can't move through a friendly piece" do
            knight.move_to("5 5")
            chess.update_position(knight)
            queen.move_to("7 4")
            chess.update_position(queen)
            expect(chess.board[4][6].symbol).to eq "♕ "
        end

        let (:enemy_queen) {chess.board[0][3]}
        let (:left_enemy_pawn) {chess.board[1][2]}

        it "the enemy queen can move as expected" do
            left_enemy_pawn.move_to("2 2")
            chess.update_position(left_enemy_pawn)
            enemy_queen.move_to("3 0")
            chess.update_position(enemy_queen)
            expect(chess.board[3][0].symbol).to eq "♛ "
        end
        
    end
    
end