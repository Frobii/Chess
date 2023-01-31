module Check
    def check?(piece)
        x, y = piece.position[0].to_i, piece.position[1].to_i

        return false unless piece.is_a?(King)

        horizontal_directions = [[-1,0], [1,0], [0,-1], [0,1]]
        diagonal_directions = [[-1,-1], [-1,1], [1,-1], [1,1]]

        directions = horizontal_directions + diagonal_directions

        diagonal_directions.each do |dx, dy|
            i, j = x, y

            loop do
            i, j = i + dx, j + dy
            break if i < 0 || i > 7 || j < 0 || j > 7

            target = board[i][j]
            return true if target.is_a?(Bishop) && target.color != piece.color
            return true if target.is_a?(Queen) && target.color != piece.color
            break if target != nil

            end

        end

        horizontal_directions.each do |dx, dy|
            i, j = x, y

            loop do
            i, j = i + dx, j + dy
            break if i < 0 || i > 7 || j < 0 || j > 7

            target = board[i][j]

            return true if target.is_a?(Queen) && target.color != piece.color
            return true if target.is_a?(Rook) && target.color != piece.color
            break if target != nil

            end

        end

        pawn_directions = [[piece.color == 'w' ? -1 : 1, -1], [piece.color == 'b' ? -1 : 1, 1]]

        pawn_directions.each do |dx, dy|
            i, j = x + dx, y + dy
            next if i < 0 || i > 7 || j < 0 || j > 7

            target = board[i][j]
            return true if target.is_a?(Pawn) && target.color != piece.color
        end

        knight_directions = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
        
        knight_directions.each do |dx, dy|
            i, j = x + dx, y + dy
            next if i < 0 || i > 7 || j < 0 || j > 7

            target = board[i][j]
            return true if target.is_a?(Knight) && target.color != piece.color
        end

        opposing_color = piece.color == "w" ? "b" : "w"
        opposing_king = board.flatten.select { |p| p.is_a?(King) && p.color == opposing_color }.first
        return true if directions.any? { |dx, dy| opposing_king.position == [x + dx, y + dy] }
        
        false
        
    end

    def check_mate?(king)
    
    end
end