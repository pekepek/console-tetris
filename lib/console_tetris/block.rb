class ConsoleTetris
  module Block
    module_function

    def type_j(degree)
      case degree
      when 0
        [
          [1, 1, 1, 1],
          [0, 0, 0, 1]
        ]
      when 90
        [
          [0, 1],
          [0, 1],
          [0, 1],
          [1, 1]
        ]
      when 180
        [
          [1, 0, 0, 0],
          [1, 1, 1, 1]
        ]
      when 270
        [
          [1, 1],
          [1, 0],
          [1, 0],
          [1, 0]
        ]
      end
    end

    def type_l(degree)
      case degree
      when 0
        [
          [1, 1, 1, 1],
          [1, 0, 0, 0]
        ]
      when 90
        [
          [1, 1],
          [0, 1],
          [0, 1],
          [0, 1]
        ]
      when 180
        [
          [0, 0, 0, 1],
          [1, 1, 1, 1]
        ]
      when 270
        [
          [1, 0],
          [1, 0],
          [1, 0],
          [1, 1]
        ]
      end
    end

    def type_i(degree)
      case degree
      when 0, 180
        [
          [1, 1, 1, 1]
        ]
      when 90, 270
        [
          [1],
          [1],
          [1],
          [1]
        ]
      end
    end

    def type_o(degree)
      [
        [1, 1],
        [1, 1]
      ]
    end

    def type_s(degree)
      case degree
      when 0, 180
        [
          [0, 1, 1],
          [1, 1, 0]
        ]
      when 90, 270
        [
          [1, 0],
          [1, 1],
          [0, 1]
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
          [1, 1, 1],
          [0, 1, 0]
        ]
      when 90
        [
          [0, 1],
          [1, 1],
          [0, 1]
        ]
      when 180
        [
          [0, 1, 0],
          [1, 1, 1]
        ]
      when 270
        [
          [1, 0],
          [1, 1],
          [1, 0]
        ]
      end
    end
  end
end
