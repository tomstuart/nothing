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

  # Combinators

  Y = -> f { -> x { f[       x[x]     ] }[-> x { f[       x[x]     ] }] } # the famous one, for lazy languages like Haskell
  Z = -> f { -> x { f[-> _ { x[x][_] }] }[-> x { f[-> _ { x[x][_] }] }] } # eta-expanded Y combinator, for eager languages like Ruby

  # Natural numbers with recursion

  FACTORIAL = Z[-> f { -> n { IF[IS_ZERO[n]][ONE][-> _ { MULTIPLY[n][f[DECREMENT[n]]][_] }] } }]
  DIV       = Z[-> f { -> m { -> n { IF[IS_LESS_OR_EQUAL[n][m]][-> _ { INCREMENT[f[SUBTRACT[m][n]][n]][_] }][ZERO] } } }]
  MOD       = Z[-> f { -> m { -> n { IF[IS_LESS_OR_EQUAL[n][m]][-> _ { f[SUBTRACT[m][n]][n][_] }][m] } } }]

  # Pairs

  PAIR  = -> x { -> y { -> f { f[x][y] } } }
  LEFT  = -> p { p[-> x { -> y { x } } ] }
  RIGHT = -> p { p[-> x { -> y { y } } ] }

  # Lists

  EMPTY     = PAIR[TRUE][TRUE]
  UNSHIFT   = -> x { -> l { PAIR[FALSE][PAIR[x][l]] } }
  IS_EMPTY  = LEFT
  FIRST     = -> l { LEFT[RIGHT[l]] }
  REST      = -> l { RIGHT[RIGHT[l]] }

  INJECT  = Z[-> f { -> l { -> x { -> g { IF[IS_EMPTY[l]][x][-> _ { f[REST[l]][g[x][FIRST[l]]][g][_] }] } } } }]
  FOLD    = Z[-> f { -> l { -> x { -> g { IF[IS_EMPTY[l]][x][-> _ { g[f[REST[l]][x][g]][FIRST[l]][_] }] } } } }]
  MAP     = -> k { -> f { FOLD[k][EMPTY][-> l { -> x { UNSHIFT[f[x]][l] } }] } }

  RANGE   = Z[-> f { -> m { -> n { IF[IS_LESS_OR_EQUAL[m][n]][-> _ { UNSHIFT[m][f[INCREMENT[m]][n]][_] }][EMPTY] } } }]
  SUM     = -> l { INJECT[l][ZERO][ADD] }
  PRODUCT = -> l { INJECT[l][ONE][MULTIPLY] }
  CONCAT  = -> j { -> k { FOLD[j][k][-> l { -> x { UNSHIFT[x][l] } }] } }
  PUSH    = -> l { -> x { CONCAT[l][UNSHIFT[x][EMPTY]] } }
  REVERSE = -> l { FOLD[l][EMPTY][PUSH] }

  INCREMENT_ALL = -> l { MAP[l][INCREMENT] }
  DOUBLE_ALL    = -> l { MAP[l][MULTIPLY[TWO]] }

  # Natural numbers with lists

  TEN       = INCREMENT[MULTIPLY[THREE][THREE]]
  RADIX     = TEN
  TO_DIGITS = Z[-> f { -> n { PUSH[IF[IS_LESS_OR_EQUAL[n][DECREMENT[RADIX]]][EMPTY][ -> _ { f[DIV[n][RADIX]][_] } ]][MOD[n][RADIX]] } }]
  TO_CHAR   = -> n { n } # assume string encoding where 0 encodes '0', 1 encodes '1' etc
  TO_STRING = -> n { MAP[TO_DIGITS[n]][TO_CHAR] }

  # FizzBuzz

  FOUR    = INCREMENT[THREE]
  FIVE    = INCREMENT[FOUR]
  FIFTEEN = MULTIPLY[THREE][FIVE]
  FIZZ    = MAP[UNSHIFT[ONE][UNSHIFT[TWO][UNSHIFT[FOUR][UNSHIFT[FOUR][EMPTY]]]]][ADD[RADIX]]
  BUZZ    = MAP[UNSHIFT[ZERO][UNSHIFT[THREE][UNSHIFT[FOUR][UNSHIFT[FOUR][EMPTY]]]]][ADD[RADIX]]

  FIZZBUZZ =
    -> m { MAP[RANGE[ONE][m]][-> n {
      IF[IS_ZERO[MOD[n][FIFTEEN]]][
        CONCAT[FIZZ][BUZZ]
      ][IF[IS_ZERO[MOD[n][THREE]]][
        FIZZ
      ][IF[IS_ZERO[MOD[n][FIVE]]][
        BUZZ
      ][
        TO_STRING[n]
      ]]]
    }] }
end
