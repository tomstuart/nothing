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
  IF    = -> b { b }

  NOT = -> b { IF[b][FALSE][TRUE] }
  AND = -> a { -> b { IF[a][IF[b][TRUE][FALSE]][FALSE] } }
  OR  = -> a { -> b { IF[a][TRUE][IF[b][TRUE][FALSE]] } }

  # Natural numbers with booleans

  IS_ZERO           = -> n { n[-> x { FALSE }][TRUE] }
  IS_LESS_OR_EQUAL  = -> m { -> n { IS_ZERO[SUBTRACT[m][n]] } }
  IS_EQUAL          = -> m { -> n { AND[IS_LESS_OR_EQUAL[m][n]][IS_LESS_OR_EQUAL[n][m]] } }

  # Natural numbers with recursion

  FACT      = -> f { -> n { IF[IS_ZERO[n]][ONE][-> _ { MULTIPLY[n][f[f][DECREMENT[n]]][_] }] } }
  FACTORIAL = FACT[FACT]
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
