require 'support/ffi'

RSpec::Matchers.define :represent do |value|
  include Nothing::FFI

  def represents?(representation, value)
    case value
    when Integer
      to_integer(representation) == value
    when TrueClass, FalseClass
      to_boolean(representation) == value
    when Pair
      pair = to_pair(representation)
      represents?(pair.left, value.left) && represents?(pair.right, value.right)
    when Array
      array = to_array(representation)
      (array.length == value.length) && array.zip(value).all? { |r, v| represents?(r, v) }
    when String
      to_string(representation) == value
    else
      fail "don't know how to represent #{value.inspect}"
    end
  end

  match do |representation|
    represents?(representation, value)
  end
end
