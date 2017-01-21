# frozen_string_literal: true

class ConsoleTetris
  module AsciiArt
    GAMEOVER = <<-'EOS'
  _____          __  __  _____   ______      ________  _____
 / ____|   /\   |  \/  ||  ___| / __ \ \    / /  ____||  __ \
| |  __   /  \  | \  / || |__  | |  | \ \  / /| |__   | |__) |
| | |_ | / /\ \ | |\/| ||  __| | |  | |\ \/ / |  __|  |  _  /
| |__| |/ ____ \| |  | || |___ | |__| | \  /  | |____ | | \ \
 \_____/_/    \_\_|  |_||_____| \____/   \/   |______||_|  \_\
    EOS

    ONE = <<-'EOS'
 __
/_ |
 | |
 | |
 | |
 |_|
    EOS

    TWO = <<-'EOS'
 ___
|__ \
   ) |
  / /
 / /_
|____|
    EOS

    THREE = <<-'EOS'
 ____
|___ \
  __) |
 |__ <
 ___) |
|____/
    EOS

    FOUR = <<-'EOS'
 _  _
| || |
| || |_
|__   _|
   | |
   |_|
    EOS

    FIVE = <<-'EOS'
 _____
| ____|
| |__
|___ \
 ___) |
|____/
    EOS

    SIX = <<-'EOS'
   __
  / /
 / /_
| '_ \
| (_) |
 \___/
    EOS

    SEVEN = <<-'EOS'
 ______
|____  |
    / /
   / /
  / /
 /_/
    EOS

    EIGHT = <<-'EOS'
  ___
 / _ \
| (_) |
 > _ <
| (_) |
 \___/
    EOS

    NINE = <<-'EOS'
  ___
 / _ \
| (_) |
 \__, |
   / /
  /_/
    EOS

    ZERO = <<-'EOS'
  ___
 / _ \
| | | |
| | | |
| |_| |
 \___/
    EOS

    NUMBER_TO_ENGLISH = {
      1 => 'one',
      2 => 'two',
      3 => 'three',
      4 => 'four',
      5 => 'five',
      6 => 'six',
      7 => 'seven',
      8 => 'eight',
      9 => 'nine',
      0 => 'zero'
    }.freeze

    module_function

    def number_to_aa(number)
      number_aas = number.to_s.chars.map {|c| const_get(NUMBER_TO_ENGLISH[c.to_i].upcase) }

      splitted_number_aas = number_aas.map {|n| n.split("\n") }

      6.times.map {|i|
        splitted_number_aas.map {|aa|
          max_length = aa.map(&:size).max
          aa[i].to_s.ljust(max_length)
        }.join('')
      }.join("\n")
    end
  end
end
