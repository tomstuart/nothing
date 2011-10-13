require 'spec_helper'

describe Nothing do
  include Nothing

  describe 'natural numbers' do
    specify { ZERO.should represent 0 }
    specify { ONE.should represent 1 }
    specify { TWO.should represent 2 }
    specify { THREE.should represent 3 }

    specify { TIMES[representation_of 3][-> s { s + 'o' }]['hell'].should == 'hellooo' }
    specify { INCREMENT[representation_of 2].should represent 2 + 1 }
    specify { ADD[representation_of 2][representation_of 3].should represent 2 + 3 }
    specify { MULTIPLY[representation_of 2][representation_of 3].should represent 2 * 3 }
    specify { POWER[representation_of 2][representation_of 3].should represent 2 ** 3 }
    specify { DECREMENT[representation_of 3].should represent 3 - 1 }
    specify { SUBTRACT[representation_of 3][representation_of 2].should represent 3 - 2 }

    context 'with booleans' do
      (0..3).each do |n|
        specify { IS_ZERO[representation_of n].should represent n.zero? }
        specify { IS_LESS_OR_EQUAL[representation_of n][representation_of 2].should represent n <= 2 }
        specify { IS_EQUAL[representation_of n][representation_of 2].should represent n == 2 }
      end
    end

    context 'with recursion' do
      (0..5).zip([1, 1, 2, 6, 24, 120]) do |n, n_factorial|
        specify { FACTORIAL[representation_of n].should represent n_factorial }
      end

      [0, 1, 11, 27].product([1, 3, 11]) do |m, n|
        specify { DIV[representation_of m][representation_of n].should represent m / n }
        specify { MOD[representation_of m][representation_of n].should represent m % n }
      end
    end

    context 'with lists' do
      specify { pending { TO_DIGITS[representation_of 42].should represent [4, 2] } }
    end

    context 'with strings' do
      specify { pending { TO_STRING[representation_of 42].should represent '42' } }
    end
  end

  describe 'booleans' do
    specify { TRUE.should represent true }
    specify { FALSE.should represent false }

    let(:foo) { Object.new }
    let(:bar) { Object.new }

    [true, false].each do |b|
      specify { IF[representation_of b][foo][bar].should equal(if b then foo else bar end) }
      specify { NOT[representation_of b].should represent !b }

      [true, false].each do |a|
        specify { AND[representation_of a][representation_of b].should represent a && b }
        specify { OR[representation_of a][representation_of b].should represent a || b }
      end
    end
  end

  describe 'pairs' do
    specify { PAIR[representation_of 3][representation_of 5].should represent Pair.new(3, 5) }

    let(:foo) { Object.new }
    let(:bar) { Object.new }

    specify { LEFT[PAIR[foo][bar]].should equal(foo) }
    specify { RIGHT[PAIR[foo][bar]].should equal(bar) }
  end

  describe 'lists' do
    specify { EMPTY.should represent [] }
    specify { pending { UNSHIFT[representation_of [2, 3]][representation_of 1].should represent [1, 2, 3] } }

    specify { IS_EMPTY[representation_of []].should represent true }
    specify { IS_EMPTY[representation_of [1]].should represent false }
    specify { FIRST[representation_of [1, 2, 3]].should represent 1 }
    specify { pending { REST[representation_of [1, 2, 3]].should represent [2, 3] } }

    specify { pending { RANGE[representation_of 2][representation_of 8].should represent [2, 3, 4, 5, 6, 7, 8] } }
    specify { pending { SUM[representation_of [2, 2, 3]].should represent 7 } }
    specify { pending { PRODUCT[representation_of [2, 2, 3]].should represent 12 } }
    specify { pending { CONCAT[representation_of [1, 2]][representation_of [3, 2]].should represent [1, 2, 3, 2] } }
    specify { pending { PUSH[representation_of [1, 2]][representation_of 3].should represent [1, 2, 3] } }
    specify { pending { REVERSE[representation_of [1, 2, 3]].should represent [3, 2, 1] } }

    specify { pending { INCREMENT_ALL[representation_of [1, 2, 3]].should represent [2, 3, 4] } }
    specify { pending { DOUBLE_ALL[representation_of [1, 2, 3]].should represent [2, 4, 6] } }
  end

  describe 'FizzBuzz' do
    def fizzbuzz(m)
      (1..m).map { |n| (n % 15).zero? ? 'FizzBuzz' : (n % 3).zero? ? 'Fizz' : (n % 5).zero? ? 'Buzz' : n.to_s }
    end

    specify { pending { FIZZBUZZ[representation_of 30].should represent fizzbuzz(30) } }
  end
end
