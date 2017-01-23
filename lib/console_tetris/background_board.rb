require_relative './ascii_art'

class ConsoleTetris
  class BackgroundBoard
    attr_accessor :point

    BOARD_SIZE = {x: 10, y: 20}

    def initialize
      @board = blank_board
      @point = 0
    end

    def stack!(tetrimino)
      tetrimino.block.each.with_index {|row, i| row.each.with_index {|value, j| @board[tetrimino.y_coordinate + i][tetrimino.x_coordinate + j] += value } }
    end

    def overlap?(tetrimino)
      tetrimino.block.map.with_index.any? {|row, i|
        row.map.with_index.any? {|value, j|
          return false if @board[tetrimino.y_coordinate + i].nil?

          @board[tetrimino.y_coordinate + i][tetrimino.x_coordinate + j] > 0 && value > 0
        }
      }
    end

    def remove_filled_line!
      @board.reject! {|a| a.all? {|e| e != 0 } }

      remove_size = BOARD_SIZE[:y] - @board.count

      @point = @point + remove_size * 1000
      remove_size.times { @board.unshift(blank_line) }
    end

    def print_point
      print "\e[3;1H"

      print "\e[13G"
      print "\e[K"
      print "#{@point.to_s.rjust(6, ' ')} P\n"

      print "\e[13G"
      print "\e[K"
      print "-------- \n"
    end

    def print_next_block(tetrimino)
      block = tetrimino.block.map {|row|
        row.map {|b|
          next '  ' if b == 0

          "\e[3#{b}m[]"
        }.join('') + "\e[0m"
      }

      print "\e[5;1H"
      print "\e[1J"
      print "\e[1;1H"

      print "\e[G ---------- \n"
      print "\e[G| #{block[0].to_s.center(8, ' ')} |\n"
      print "\e[G| #{block[1].to_s.center(8, ' ')} |\n"
      print "\e[G ---------- \n"
    end

    def print_block(tetrimino)
      dup_board = @board.map {|board| board.dup }

      tetrimino.block.each.with_index {|row, i|
        row.each.with_index {|value, j|
          next if dup_board[tetrimino.y_coordinate + i][tetrimino.x_coordinate + j].nil?

          dup_board[tetrimino.y_coordinate + i][tetrimino.x_coordinate + j] += value
        }
      }

      print_point

      print "\e[5;1H"
      print "\e[J"

      print "\e[G"
      print '__' * BOARD_SIZE[:x]
      print "\n"

      dup_board.each do |elements|
        print "\e[G"

        elements.each do |el|
          print case el
            when 0
              '  '
            when 1..7
              "\e[3#{el}m[]"
            end
        end

        print "\e[0m"

        print "|\n"
      end

      print "\e[G"
      print '‾‾' * BOARD_SIZE[:x]
    end

    def print_gameover
      print "\e[2J"
      print "\e[1;1H"
      print "#{AsciiArt.number_to_aa(point).gsub(/^/, "\e[G")} Points!!!!\n"
      print AsciiArt::GAMEOVER.gsub(/^/, "\e[G")
    end

    private

    def blank_board
      BOARD_SIZE[:y].times.map { blank_line }
    end

    def blank_line
      Array.new(BOARD_SIZE[:x]).fill(0)
    end
  end
end
