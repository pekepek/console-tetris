require_relative './console_tetris/version'
require_relative './console_tetris/tetrimino'
require_relative './console_tetris/background_board'
require 'io/console'

class ConsoleTetris
  BLOCK_TYPES = %w(i j l o s t z)

  def self.start
    @background_board = BackgroundBoard.new

    @tetrimino = Tetrimino.new(block_type: "type_#{BLOCK_TYPES.sample}")
    next_tetrimino = Tetrimino.new(block_type: "type_#{BLOCK_TYPES.sample}")

    @background_board.print_next_block(next_tetrimino)
    @background_board.print_block(@tetrimino)

    Thread.new do
      catch :gameover do
        loop do
          loop.with_index do |_, i|
            @tetrimino.down

            @background_board.print_block(@tetrimino) unless @background_board.overlap?(@tetrimino)

            sleep 0.1

            if @tetrimino.bottom_edge? || @background_board.overlap?(@tetrimino)
              throw :gameover if i == 0

              @tetrimino.back_vertically if @background_board.overlap?(@tetrimino)

              break
            end
          end

          @background_board.stack!(@tetrimino)
          @background_board.remove_filled_line!

          @background_board.print_block(@tetrimino)

          @tetrimino = next_tetrimino
          next_tetrimino = Tetrimino.new(block_type: "type_#{BLOCK_TYPES.sample}")

          @background_board.print_next_block(next_tetrimino)
        end
      end

      @background_board.print_gameover

      exit
    end

    while (str = STDIN.getch) != "\C-c"
      case str
      when 'x'
        next if @tetrimino.right_edge?

        @tetrimino.move_right
        @tetrimino.back_horizontally if @background_board.overlap?(@tetrimino)
      when 'z'
        next if @tetrimino.left_edge?

        @tetrimino.move_left
        @tetrimino.back_horizontally if @background_board.overlap?(@tetrimino)
      when ' '
        @tetrimino.rotate

        loop do
          if @background_board.overlap?(@tetrimino)
            @tetrimino.up
          else
            break
          end
        end
      end

      @background_board.print_block(@tetrimino)
    end
  end
end
