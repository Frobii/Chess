module Check_Rules
    def check?(piece, x = 0, y = 0, suit = nil)
        return false unless piece.is_a?(King) || piece.nil?

        # allow nil to be passed for check_mate validation
        x, y = piece.position[0].to_i, piece.position[1].to_i if !piece.nil?

        suit = piece.color if !piece.nil?

        horizontal_directions = [[-1,0], [1,0], [0,-1], [0,1]]
        diagonal_directions = [[-1,-1], [-1,1], [1,-1], [1,1]]

        directions = horizontal_directions + diagonal_directions

        diagonal_directions.each do |dx, dy|
            i, j = x, y

            loop do
                i, j = i + dx, j + dy
                break if i < 0 || i > 7 || j < 0 || j > 7

                target = board[i][j]

                return true if target.is_a?(Bishop) && target.color != suit
                return true if target.is_a?(Queen) && target.color != suit
                break if target != nil

            end

        end

        horizontal_directions.each do |dx, dy|
            i, j = x, y

            loop do
                i, j = i + dx, j + dy
                break if i < 0 || i > 7 || j < 0 || j > 7

                target = board[i][j]

                return true if target.is_a?(Queen) && target.color != suit
                return true if target.is_a?(Rook) && target.color != suit
                break if target != nil

            end

        end

        pawn_directions = [[suit == 'w' ? -1 : 1, -1], [suit == 'b' ? -1 : 1, 1]]

        pawn_directions.each do |dx, dy|
            i, j = x + dx, y + dy
            next if i < 0 || i > 7 || j < 0 || j > 7

            target = board[i][j]
            return true if target.is_a?(Pawn) && target.color != suit
        end

        knight_directions = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
        
        knight_directions.each do |dx, dy|
            i, j = x + dx, y + dy
            next if i < 0 || i > 7 || j < 0 || j > 7

            target = board[i][j]
            return true if target.is_a?(Knight) && target.color != suit
        end

        opposing_color = suit == "w" ? "b" : "w"
        opposing_king = board.flatten.select { |p| p.is_a?(King) && p.color == opposing_color }.first
        return true if directions.any? { |dx, dy| opposing_king.position == [x + dx, y + dy] }
        
        false
        
    end

    def check_mate?(king)
        return false unless check?(king)
        return false if !valid_check_mate?(king)

        x, y = king.position[0].to_i, king.position[1].to_i

        king_directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

        king_directions.each do |dx, dy|
            i, j = x + dx, y + dy
            next if i < 0 || i > 7 || j < 0 || j > 7
            
            # remove the king from the board so that it doesn't block a taker from itself during the check? verification
            board[x][y] = nil

            in_check = check?(nil, i, j, king.color)

            board[x][y] = king

            return false if !in_check
            
        end

        true

    end

    # modify check? to push any threats to an array
    def piece_search(piece)
        threats = []

        return if piece.nil?

        x, y = piece.position[0].to_i, piece.position[1].to_i

        suit = piece.color

        horizontal_directions = [[-1,0], [1,0], [0,-1], [0,1]]
        diagonal_directions = [[-1,-1], [-1,1], [1,-1], [1,1]]

        directions = horizontal_directions + diagonal_directions

        diagonal_directions.each do |dx, dy|
            i, j = x, y

            loop do
                i, j = i + dx, j + dy
                break if i < 0 || i > 7 || j < 0 || j > 7

                target = board[i][j]

                threats.push(target) if target.is_a?(Bishop) && target.color != suit
                threats.push(target) if target.is_a?(Queen) && target.color != suit
                break if target != nil

            end

        end

        horizontal_directions.each do |dx, dy|
            i, j = x, y

            loop do
                i, j = i + dx, j + dy
                break if i < 0 || i > 7 || j < 0 || j > 7

                target = board[i][j]

                threats.push(target) if target.is_a?(Queen) && target.color != suit
                threats.push(target) if target.is_a?(Rook) && target.color != suit
                break if target != nil

            end

        end

        pawn_directions = [[suit == 'w' ? -1 : 1, -1], [suit == 'b' ? -1 : 1, 1]]

        pawn_directions.each do |dx, dy|
            i, j = x + dx, y + dy
            next if i < 0 || i > 7 || j < 0 || j > 7

            target = board[i][j]
            threats.push(target) if target.is_a?(Pawn) && target.color != suit
        end

        knight_directions = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
        
        knight_directions.each do |dx, dy|
            i, j = x + dx, y + dy
            next if i < 0 || i > 7 || j < 0 || j > 7

            target = board[i][j]
            threats.push(target) if target.is_a?(Knight) && target.color != suit
        end
        
        return threats
        
    end

    def valid_check_mate?(king)
        king_threats = piece_search(king)

        # accounts for double check (bishop, knight)
        return true if king_threats.length > 1 

        attacker = king_threats[0]

        attacker_threats = piece_search(attacker)

        return false if attacker_threats.length >= 1

        true
        
    end

end
