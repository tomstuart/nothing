require 'support/ffi'
require 'support/pair'

module Helpers
  include Nothing::FFI

  def representation_of(value)
    case value
    when Integer
      from_integer value
    when TrueClass, FalseClass
      from_boolean value
    when Pair
      pair = Pair.new(representation_of(value.left), representation_of(value.right))
      from_pair pair
    when Array
      array = value.map { |v| representation_of v }
      from_array array
    when String
      from_string value
    else
      fail "don't know how to represent #{value.inspect}"
    end
  end
end
