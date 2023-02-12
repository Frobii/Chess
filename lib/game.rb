require 'colorize'

module Play_Game
    
    def play

        loop do
            make_move("w")
            break if game_over?("b")

            make_move("b")
            break if game_over?("w")
        end

        draw_board
        puts "White wins!".green if game_over?("b")
        puts "Black wins!".green if game_over?("w")

    end

    def game_over?(color)
        king = board.flatten.select { |p| p.is_a?(King) && p.color == color }.first
        return check_mate?(king)
    end

    def make_move(player)
        loop do
            draw_board
            selection = ''
            move = ''

            color = "White".green if player == 'w'
            color = "Black".blue if player == 'b'

            loop do
                puts "#{color}, select a piece with the following format: 'x y'"
                selection = gets.chomp.split(" ")
                break if selection.length == 2 && selection.all? { |num| num.to_i.is_a?(Integer)} && selection.all? { |num| num.to_i.between?(0,7)}
            end
            
            x,y = selection[0].to_i, selection[1].to_i
            piece = board[x][y]

            puts "\n" if piece.nil? || piece.color != player
            puts "invalid selection".red if piece.nil? || piece.color != player

            next if piece.nil? || piece.color != player

            loop do
                puts "Select it's location with the following format: 'x y'"
                move = gets.chomp.split(" ") 
                break if move.length == 2 && move.all? { |num| num.to_i.is_a?(Integer)} && move.all? { |num| num.to_i.between?(0,7)}
            end

            new_x,new_y = move[0].to_i, move[1].to_i

            puts "\n", "You must move a piece".red if x == new_x && y == new_y
            next if x == new_x && y == new_y
            
            piece.move_to(move.join(" "))
            
            update_position(piece)
            
            puts "\n"
            
            break if board[new_x][new_y] == piece
            
            puts "the piece you chose cannot be moved that way".red
            
        end
        

    end

end
