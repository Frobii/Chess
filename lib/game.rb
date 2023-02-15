require 'colorize'
require 'json'

module Play_Game
    attr_accessor :menu_choice
    
    def play(turn = "w", board = @board)
       
        puts "Type #{"new".red} to initialize a new game"
        puts "Type #{"load".blue} to load a game in progress"
        puts "Type #{"save".green} at any point to save your current game"

        loop do
            @menu_choice = gets.chomp
            break if menu_choice.downcase == "new" || menu_choice.downcase == "load"
            puts "Type #{"new".red} to initialize a new game"
            puts "Type #{"load".blue} to load a game in progress"
            puts "Type #{"save".green} at any point to save your current game"
        end

        puts "\n"

        if menu_choice == "new"
            game_cycle(turn)

        elsif menu_choice == "load"
            load_game

        end

    end

    def game_cycle(turn)
        loop do
            make_move(turn) if turn == "w"
            turn = "b"

            if game_over?("b")
                draw_board
                puts "Checkmate"
                puts "White wins!".green if game_over?("b")
                break
            end

            make_move(turn) if turn == "b"
            turn = "w"

            if game_over?("w")
                draw_board
                puts "Checkmate"
                puts "Black wins!".blue if game_over?("w")
                break 
            end

        end
    end

    def save_game(turn)
        Dir.mkdir('./saves') unless Dir.exist?('./saves')

        save = 1

        while File.exist?("./saves/" + save.to_s + ".json")
            save += 1 
        end

        filename = "./saves/" + save.to_s + ".json"

        data = {
            :turn => turn,
            :board => @board
        }
    
        File.open(filename, 'w') do |file|
            file.write(data.to_json(create_additions: true)) 
        end

        puts "Your save number is: ".cyan + "#{save.to_s}".cyan.bold
        exit()
    
    end

    def load_game
        puts "Please enter your save number".cyan
        file_number = gets.chomp.to_s

        # begin
            file = File.read("./saves/#{file_number}.json")
            serialized_data = JSON.parse(file, create_additions: true)
        # rescue 
        #     puts "The specified save number cannot be found".red
        #     puts "\n"
        #     return
        # end 

        puts "\n"
        turn = serialized_data["turn"]
        @board = serialized_data["board"]

        game_cycle(turn)

    end

    def game_over?(color)
        king = board.flatten.select { |p| p.is_a?(King) && p.color == color }.first
        return check_mate?(king)
    end

    def make_move(turn)
        loop do
            draw_board
            selection = ''
            move = ''

            color = "White".green if turn == 'w'
            color = "Black".blue if turn == 'b'

            loop do
                puts "#{color}, select a piece with the following format: 'xy'"
                selection = gets.chomp.split("")
                save_game(turn) if selection.join("") == "save"
                return if selection.join("") == "save"
                break if selection.length == 2 && selection.all? { |num| num.to_i.is_a?(Integer)} && selection.all? { |num| num.to_i.between?(0,7)}
            end
            
            x,y = selection[0].to_i, selection[1].to_i
            piece = board[x][y]

            puts "\n" if piece.nil? || piece.color != turn
            puts "invalid selection".red if piece.nil? || piece.color != turn

            next if piece.nil? || piece.color != turn

            loop do
                puts "Select it's location with the following format: 'xy'"
                move = gets.chomp.split("")
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
