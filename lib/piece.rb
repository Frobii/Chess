class Piece
    attr_accessor :color, :position, :old_position

    def initialize(color, position, old_position = nil)
        @color = color
        @position = position
        @old_position = old_position
    end

    def move_to(input)

        @old_position = @position

        new_position = input.split(" ")
        @position = new_position

    end

    def self.json_create(data)
        new(data['color'], data['position'], data['old_position'])
    end
    
    def to_json(*args)
        {
            JSON.create_id => self.class.name,
            'color' => @color,
            'position' => @position,
            'old_position' => @old_position
        }.to_json(*args)
    end
end
