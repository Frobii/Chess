require_relative "../lib/board.rb"

describe "#move_to" do
    subject(:chess) { Board.new }
  
    let(:piece) { chess.board[6][0] }
  
    context "when a pawn is moved" do

        it "allows the pawn to move forwards one positon" do
            piece.move_to("5 0")
            chess.update_position(piece)
            expect(chess.board[5][0].symbol).to eq "♙ "
        end

        it "updates the previous location to nil on the board" do
            piece.move_to("5 0")
            chess.update_position(piece)
            expect(chess.board[6][0]).to eq nil
        end

        it "doesn't allow the pawn to move forward two positions after it's first move" do
            piece.move_to("5 0")
            chess.update_position(piece)
            piece.move_to("3 0")
            chess.update_position(piece)
            expect(chess.board[3][0]).to eq nil
        end

        it "doesn't allow the pawn to wrap around the board" do
            piece.move_to("4 7")
            chess.update_position(piece)
            expect(chess.board[6][0].symbol).to eq "♙ "
        end

    end

    let(:opponent_piece) { chess.board[1][1] }

    context "when a pawn is taking" do
        before do
            opponent_piece.move_to("3 1")
            chess.update_position(opponent_piece)
            piece.move_to("4 0")
            chess.update_position(piece)
        end

        it "allows a diagonal move" do
            piece.move_to("3 1")
            chess.update_position(piece)
            expect(chess.board[3][1].symbol).to eq "♙ "
        end

    end

    let(:blocking_piece) { chess.board[1][0] }

    context "when a pawn is in front of another pawn" do
        before do 
            blocking_piece.move_to("3 0")
            chess.update_position(blocking_piece)
            piece.move_to("4 0")
            chess.update_position(piece)
        end

        it "cannot take the other pawn" do
            piece.move_to("3 0")
            chess.update_position(piece)
            expect(chess.board[3][0].symbol).to eq "♟︎ "
        end
        
    end

    let(:friendly_block) { chess.board[6][1] }

    context "a white pawn is behind another white pawn" do
        before do
            blocking_piece.move_to("3 0")
            chess.update_position(blocking_piece)
            friendly_block.move_to("4 1")
            chess.update_position(friendly_block)
            friendly_block.move_to("3 0")
            chess.update_position(friendly_block)
            piece.move_to("4 0")
            chess.update_position(piece)
        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "can't move" do
            piece.move_to("3 0")
            chess.update_position(piece)
            expect(chess.board[4][0].symbol).to eq "♙ "
        end

    end

end

describe "#upgrade_pawn_white" do
    subject(:chess) { Board.new }
    
    let(:pawn) { chess.board[6][0] }
    
    before do
        # remove the pieces for ease of testing
        chess.board[0].map! {|piece| piece = nil}
        chess.board[1].map! {|pawn| pawn = nil}
        chess.board[7].map! {|piece| piece = nil}
        pawn.move_to('4 0')
        chess.update_position(pawn)
        pawn.move_to('3 0')
        chess.update_position(pawn)
        pawn.move_to('2 0')
        chess.update_position(pawn)
        pawn.move_to('1 0')
        chess.update_position(pawn)
    end
    
    after do
        puts "\n"
        chess.draw_board
    end

    it "upgrades a white pawn to a queen" do
        allow(chess).to receive(:gets).and_return("1")
        pawn.move_to('0 0')
        chess.update_position(pawn)
        expect(chess.board[0][0].symbol).to eq "♕ "
    end

    it "upgrades a white pawn to a Rook" do
        allow(chess).to receive(:gets).and_return("2")
        pawn.move_to('0 0')
        chess.update_position(pawn)
        expect(chess.board[0][0].symbol).to eq "♖ "
    end

    it "upgrades a white pawn to a Knight" do
        allow(chess).to receive(:gets).and_return("3")
        pawn.move_to('0 0')
        chess.update_position(pawn)
        expect(chess.board[0][0].symbol).to eq "♘ "
    end

    it "upgrades a white pawn to a Bishop" do
        allow(chess).to receive(:gets).and_return("4")
        pawn.move_to('0 0')
        chess.update_position(pawn)
        expect(chess.board[0][0].symbol).to eq "♗ "
    end

    it "behaves as expected upon an wrong input" do
        allow(chess).to receive(:gets).and_return("100")
        allow(chess).to receive(:gets).and_return("1")
        pawn.move_to('0 0')
        chess.update_position(pawn)
        expect(chess.board[0][0].symbol).to eq "♕ "
    end
    

end

describe "#upgrade_pawn_black" do
    subject(:chess) { Board.new }
    
    let(:pawn) { chess.board[1][0] }
    
    before do
        # remove the pieces for ease of testing
        chess.board[0].map! {|piece| piece = nil}
        chess.board[6].map! {|pawn| pawn = nil}
        chess.board[7].map! {|piece| piece = nil}
        pawn.move_to('3 0')
        chess.update_position(pawn)
        pawn.move_to('4 0')
        chess.update_position(pawn)
        pawn.move_to('5 0')
        chess.update_position(pawn)
        pawn.move_to('6 0')
        chess.update_position(pawn)
    end
    
    after do
        puts "\n"
        chess.draw_board
    end

    it "upgrades a black pawn to a queen" do
        allow(chess).to receive(:gets).and_return("1")
        pawn.move_to('7 0')
        chess.update_position(pawn)
        expect(chess.board[7][0].symbol).to eq "♛ "
    end

    it "upgrades a black pawn to a Rook" do
        allow(chess).to receive(:gets).and_return("2")
        pawn.move_to('7 0')
        chess.update_position(pawn)
        expect(chess.board[7][0].symbol).to eq "♜ "
    end

    it "upgrades a black pawn to a Knight" do
        allow(chess).to receive(:gets).and_return("3")
        pawn.move_to('7 0')
        chess.update_position(pawn)
        expect(chess.board[7][0].symbol).to eq "♞ "
    end

    it "upgrades a black pawn to a Bishop" do
        allow(chess).to receive(:gets).and_return("4")
        pawn.move_to('7 0')
        chess.update_position(pawn)
        expect(chess.board[7][0].symbol).to eq "♝ "
    end
    

end
