require_relative './ascii_art'

class ConsoleTetris
  class BackgroundBoard
    attr_accessor :point

    BOARD_SIZE = {x: 10, y: 20}

    class << self
      def blank_board
        BOARD_SIZE[:y].times.map { blank_line }
      end

      def blank_line
        Array.new(BOARD_SIZE[:x]).fill(0)
      end
    end

    def initialize
      @board = self.class.blank_board
      @point = 0
    end

    def stack!(block)
      @board = @board.map.with_index {|a, i| a.map.with_index {|e, j| e | block[i][j] } }
    end

    def overlap?(block)
      @board.map.with_index {|a, i| a.map.with_index {|e, j| e & block[i][j] } }.any? {|a| a.any? {|e| e > 0 } }
    end

    def remove_filled_line!
      @board.reject! {|a| a.all? {|e| e == 1 } }

      remove_size = BOARD_SIZE[:y] - @board.count

      @point = @point + remove_size * 1000
      remove_size.times { @board.unshift(self.class.blank_line) }
    end

    def print_block(block)
      print "\e[2J"
      print "\e[1;1H"

      print "\e[G _____________ \n"
      print "\e[G| #{@point.to_s.rjust(11, ' ')} |\n"
      print "\e[G ‾‾‾‾‾‾‾‾‾‾‾‾‾ \n"

      print "\e[G"
      print '__' * BOARD_SIZE[:x]
      print "\n"

      @board.map.with_index {|a, i| a.map.with_index {|e, j| e | block[i][j] } }.each do |elements|
        print "\e[G"

        elements.each do |el|
          print case el
            when 0
              '  '
            when 1
              '[]'
            end
        end

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
  end
end
