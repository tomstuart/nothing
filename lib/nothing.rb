module Nothing
  # Natural numbers

  ZERO  = -> f { -> x {       x     } }
  ONE   = -> f { -> x {     f[x]    } }
  TWO   = -> f { -> x {   f[f[x]]   } }
  THREE = -> f { -> x { f[f[f[x]]]  } }

  TIMES     = -> n { -> f { -> x { n[f][x] } } }
  INCREMENT = -> n { -> f { -> x { f[n[f][x]] } } }

  ADD       = -> m { -> n { n[INCREMENT][m] } }
  MULTIPLY  = -> m { -> n { n[ADD[m]][ZERO] } }
  POWER     = -> m { -> n { n[MULTIPLY[m]][ONE] } }
  DECREMENT = -> n { -> f { -> x { n[-> g { -> h { h[g[f]] } }][-> y { x }][-> y { y }] } } }
  SUBTRACT  = -> m { -> n { n[DECREMENT][m] } }

  # Booleans

  TRUE  = -> x { -> y { x } }
  FALSE = -> x { -> y { y } }
  IF    = -> b { -> x { -> y { b[x][y] } } }

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
