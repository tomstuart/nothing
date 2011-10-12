module Nothing
  # Natural numbers

  ZERO  = -> f { -> x {       x     } }
  ONE   = -> f { -> x {     f[x]    } }
  TWO   = -> f { -> x {   f[f[x]]   } }
  THREE = -> f { -> x { f[f[f[x]]]  } }

  TIMES     = -> n { -> f { -> x { n[f][x] } } }
  INCREMENT = -> n { -> f { -> x { f[n[f][x]] } } }

  # ADD       =
  # MULTIPLY  =
  # POWER     =
  # DECREMENT =
  # SUBTRACT  =

  # Booleans

  # TRUE  =
  # FALSE =
  # IF    =

  # NOT =
  # AND =
  # OR  =

  # Natural numbers with booleans

  # IS_ZERO           =
  # IS_LESS_OR_EQUAL  =
  # IS_EQUAL          =

  # Natural numbers with recursion

  # FACTORIAL =
  # DIV       =
  # MOD       =

  # Pairs

  # PAIR  =
  # LEFT  =
  # RIGHT =

  # Lists

  # EMPTY     =
  # UNSHIFT   =
  # IS_EMPTY  =
  # FIRST     =
  # REST      =

  # RANGE   =
  # SUM     =
  # PRODUCT =
  # CONCAT  =
  # PUSH    =
  # REVERSE =

  # INCREMENT_ALL =
  # DOUBLE_ALL    =

  # Natural numbers with lists

  # TO_DIGITS =
  # TO_STRING =

  # FizzBuzz

  # FIZZBUZZ =
end
