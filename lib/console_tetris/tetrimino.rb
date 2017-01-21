require_relative './block'

class ConsoleTetris
  class Tetrimino
    attr_accessor :x_coordinate, :y_coordinate

    def initialize(x = 0, y = 0, degree = 0, block_type:)
      @x_coordinate = x
      @y_coordinate = y
      @degree = degree
      @block_type = block_type
      @previous_state = {x: x, y: y, degree: degree}
    end

    def down
      @previous_state[:y] = @y_coordinate

      @y_coordinate += 1
    end

    def up
      @previous_state[:y] = @y_coordinate

      @y_coordinate -= 1
    end

    def move_right
      @previous_state[:x] = @x_coordinate

      @x_coordinate += 1
    end

    def move_left
      @previous_state[:x] = @x_coordinate

      @x_coordinate -= 1
    end

    def back_vertically
      @y_coordinate = @previous_state[:y]
    end

    def back_horizontally
      @x_coordinate = @previous_state[:x]
    end

    def rotate
      before_block = block

      @previous_state = {x: @x_coordinate, y: @y_coordinate, degree: @degree}
      @degree += 90
      @degree = 0 if @degree == 360

      @y_coordinate = 20 - block.size if @y_coordinate + block.size > 20
      @x_coordinate = 10 - block.first.size if @x_coordinate + block.first.size > 10

      @y_coordinate = 0 if @y_coordinate.negative?
      @x_coordinate = 0 if @x_coordinate.negative?
    end

    def block
      Block.send(@block_type, @degree)
    end

    def left_edge?
      @x_coordinate == 0
    end

    def right_edge?
      @x_coordinate + block.first.size > 9
    end

    def bottom_edge?
      @y_coordinate + block.size > 19
    end
  end
end
