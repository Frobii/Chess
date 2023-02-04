require_relative "../lib/board.rb"

describe "#check_mate?" do
    subject(:chess) { Board.new }

    context "when the king is in check_mate" do

        before do
            # remove the pieces for ease of testing

        end

        after do
            puts "\n"
            chess.draw_board
        end

        it "blank" do

        end

    end

end
