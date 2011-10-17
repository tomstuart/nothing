require 'nothing'
require 'support/pair'

module Nothing
  module FFI
    def to_integer(n)
      TIMES[n][-> integer { integer + 1 }][0]
    end

    def from_integer(integer)
      n = ZERO

      integer.times do
        n = INCREMENT[n]
      end

      n
    end

    def to_boolean(b)
      IF[b][true][false]
    end

    def from_boolean(boolean)
      if boolean then TRUE else FALSE end
    end

    def to_pair(p)
      Pair.new(LEFT[p], RIGHT[p])
    end

    def from_pair(pair)
      PAIR[pair.left][pair.right]
    end

    def to_array(l)
      array = []

      until to_boolean(IS_EMPTY[l])
        array.push(FIRST[l])
        l = REST[l]
      end

      array
    end

    def from_array(array)
      l = EMPTY

      until array.empty?
        l = UNSHIFT[l][array.last]
        array.pop
      end

      l
    end

    CHARSET = '0123456789BFiuz'.chars.entries # for encoding digits, "Fizz" and "Buzz"

    def to_char(c)
      CHARSET.at(to_integer(c))
    end

    def from_char(char)
      from_integer(CHARSET.index(char))
    end

    def to_string(s)
      to_array(s).map { |c| to_char(c) }.join
    end

    def from_string(string)
      from_array(string.chars.map { |char| from_char(char) })
    end
  end
end
