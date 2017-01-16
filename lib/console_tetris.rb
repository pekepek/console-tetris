require_relative './console_tetris/version'
require_relative './console_tetris/tetrimino'
require_relative './console_tetris/background_board'
require 'io/console'

class ConsoleTetris
  BLOCK_TYPES = %w(i j l o s t z)

  def self.start
    @background_board = BackgroundBoard.new

    type = "type_#{BLOCK_TYPES.sample}"
    @tetrimino = Tetrimino.new(block_type: type)

    @background_board.print_block(@tetrimino.block)

    Thread.new do
      catch :gameover do
        loop do
          loop.with_index do |_, i|
            @tetrimino.down

            @background_board.print_block(@tetrimino.block) unless @background_board.overlap?(@tetrimino.block)

            sleep 0.1

            if @tetrimino.bottom_edge? || @background_board.overlap?(@tetrimino.block)
              throw :gameover if i == 0

              @tetrimino.back_vertically if @background_board.overlap?(@tetrimino.block)

              break
            end
          end

          @background_board.stack!(@tetrimino.block)
          @background_board.remove_filled_line!

          @background_board.print_block(@tetrimino.block)

          type = "type_#{BLOCK_TYPES.sample}"
          @tetrimino = Tetrimino.new(block_type: type)
        end
      end

      @background_board.print_gameover

      exit
    end

    while (str = STDIN.getch) != "\C-c"
      case str
      when '.'
        next if @tetrimino.right_edge?

        @tetrimino.move_right
        @tetrimino.back_horizontally if @background_board.overlap?(@tetrimino.block)
      when 'z'
        next if @tetrimino.left_edge?

        @tetrimino.move_left
        @tetrimino.back_horizontally if @background_board.overlap?(@tetrimino.block)
      when "\r"
        @tetrimino.rotate

        loop do
          if @background_board.overlap?(@tetrimino.block)
            @tetrimino.up
          else
            break
          end
        end
      end

      @background_board.print_block(@tetrimino.block)
    end
  end
end
