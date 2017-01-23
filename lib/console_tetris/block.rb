class ConsoleTetris
  module Block
    module_function

    def type_j(degree)
      case degree
      when 0
        [
          [4, 4, 4, 4],
          [0, 0, 0, 4]
        ]
      when 90
        [
          [0, 4],
          [0, 4],
          [0, 4],
          [4, 4]
        ]
      when 180
        [
          [4, 0, 0, 0],
          [4, 4, 4, 4]
        ]
      when 270
        [
          [4, 4],
          [4, 0],
          [4, 0],
          [4, 0]
        ]
      end
    end

    def type_l(degree)
      case degree
      when 0
        [
          [7, 7, 7, 7],
          [7, 0, 0, 0]
        ]
      when 90
        [
          [7, 7],
          [0, 7],
          [0, 7],
          [0, 7]
        ]
      when 180
        [
          [0, 0, 0, 7],
          [7, 7, 7, 7]
        ]
      when 270
        [
          [7, 0],
          [7, 0],
          [7, 0],
          [7, 7]
        ]
      end
    end

    def type_i(degree)
      case degree
      when 0, 180
        [
          [6, 6, 6, 6]
        ]
      when 90, 270
        [
          [6],
          [6],
          [6],
          [6]
        ]
      end
    end

    def type_o(degree)
      [
        [3, 3],
        [3, 3]
      ]
    end

    def type_s(degree)
      case degree
      when 0, 180
        [
          [0, 2, 2],
          [2, 2, 0]
        ]
      when 90, 270
        [
          [2, 0],
          [2, 2],
          [0, 2]
        ]
      end
    end

    def type_z(degree)
      case degree
      when 0, 180
        [
          [1, 1, 0],
          [0, 1, 1]
        ]
      when 90, 270
        [
          [0, 1],
          [1, 1],
          [1, 0]
        ]
      end
    end

    def type_t(degree)
      case degree
      when 0
        [
          [5, 5, 5],
          [0, 5, 0]
        ]
      when 90
        [
          [0, 5],
          [5, 5],
          [0, 5]
        ]
      when 180
        [
          [0, 5, 0],
          [5, 5, 5]
        ]
      when 270
        [
          [5, 0],
          [5, 5],
          [5, 0]
        ]
      end
    end
  end
end
