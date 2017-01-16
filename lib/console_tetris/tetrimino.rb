require_relative './background_board'

class ConsoleTetris
  class Tetrimino
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

      @y_coordinate = @y_coordinate - before_block.max.count(1).times.count {|i| BackgroundBoard.blank_board[@y_coordinate + i].nil? }
      @x_coordinate = @x_coordinate - before_block.map {|a| a.any? {|e| e == 1} ? 1 : 0 }.count(1).times.count {|i| BackgroundBoard.blank_board[@y_coordinate][@x_coordinate + i].nil? }

      @y_coordinate = 0 if @y_coordinate.negative?
      @x_coordinate = 0 if @x_coordinate.negative?
    end

    def block
      send(@block_type)
    end

    def left_edge?
      block.any? {|a| a.first == 1 }
    end

    def right_edge?
      block.any? {|a| a.last == 1 }
    end

    def bottom_edge?
      block.last.any? {|e| e == 1 }
    end

    private

    def type_j
      board = BackgroundBoard.blank_board

      case @degree
      when 0
        4.times {|i| board[@y_coordinate][@x_coordinate + i] = 1 }

        board[@y_coordinate + 1][@x_coordinate + 3] = 1
      when 90
        4.times {|i| board[@y_coordinate + i][@x_coordinate + 1] = 1 }

        board[@y_coordinate + 3][@x_coordinate] = 1
      when 180
        4.times {|i| board[@y_coordinate][@x_coordinate + i] = 1 }

        board[@y_coordinate - 1][@x_coordinate] = 1
      when 270
        4.times {|i| board[@y_coordinate + i][@x_coordinate] = 1 }

        board[@y_coordinate][@x_coordinate + 1] = 1
      end

      board
    end

    def type_l
      board = BackgroundBoard.blank_board

      case @degree
      when 0
        4.times {|i| board[@y_coordinate][@x_coordinate + i] = 1 }

        board[@y_coordinate + 1][@x_coordinate] = 1
      when 90
        4.times {|i| board[@y_coordinate + i][@x_coordinate + 1] = 1 }

        board[@y_coordinate][@x_coordinate] = 1
      when 180
        4.times {|i| board[@y_coordinate + 1][@x_coordinate + i] = 1 }

        board[@y_coordinate][@x_coordinate + 3] = 1
      when 270
        4.times {|i| board[@y_coordinate + i][@x_coordinate] = 1 }

        board[@y_coordinate + 3][@x_coordinate + 1] = 1
      end

      board
    end

    def type_i
      board = BackgroundBoard.blank_board

      case @degree
      when 0
        4.times {|i| board[@y_coordinate][@x_coordinate + i] = 1 }
      when 90
        4.times {|i| board[@y_coordinate + i][@x_coordinate + 2] = 1 }
      when 180
        4.times {|i| board[@y_coordinate + 2][@x_coordinate + i] = 1 }
      when 270
        4.times {|i| board[@y_coordinate + i][@x_coordinate] = 1 }
      end

      board
    end

    def type_o
      board = BackgroundBoard.blank_board

      2.times {|i|
        board[@y_coordinate][@x_coordinate + i] = 1
        board[@y_coordinate + 1][@x_coordinate + i] = 1
      }

      board
    end

    def type_s
      board = BackgroundBoard.blank_board

      case @degree
      when 0, 180
        2.times {|i|
          board[@y_coordinate][@x_coordinate + i + 1] = 1
          board[@y_coordinate + 1][@x_coordinate + i] = 1
        }
      when 90, 270
        2.times {|i|
          board[@y_coordinate + i][@x_coordinate] = 1
          board[@y_coordinate + i + 1][@x_coordinate + 1] = 1
        }
      end

      board
    end

    def type_z
      board = BackgroundBoard.blank_board

      case @degree
      when 0, 180
        2.times {|i|
          board[@y_coordinate][@x_coordinate + i] = 1
          board[@y_coordinate + 1][@x_coordinate + i + 1] = 1
        }
      when 90, 270
        2.times {|i|
          board[@y_coordinate + i + 1][@x_coordinate] = 1
          board[@y_coordinate + i][@x_coordinate + 1] = 1
        }
      end

      board
    end

    def type_t
      board = BackgroundBoard.blank_board

      case @degree
      when 0
        3.times {|i| board[@y_coordinate + 1][@x_coordinate + i] = 1 }

        board[@y_coordinate + 2][@x_coordinate + 1] = 1
      when 90
        3.times {|i| board[@y_coordinate + i][@x_coordinate + 1] = 1 }

        board[@y_coordinate + 1][@x_coordinate] = 1
      when 180
        3.times {|i| board[@y_coordinate + 1][@x_coordinate + i] = 1 }

        board[@y_coordinate][@x_coordinate + 1] = 1
      when 270
        3.times {|i| board[@y_coordinate + i][@x_coordinate + 1] = 1 }

        board[@y_coordinate + 1][@x_coordinate + 2] = 1
      end

      board
    end
  end
end
