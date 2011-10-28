module Nothing
  # Natural numbers

  ZERO  = -> f { -> x {       x     } }
  ONE   = -> f { -> x {     f[x]    } }
  TWO   = -> f { -> x {   f[f[x]]   } }
  THREE = -> f { -> x { f[f[f[x]]]  } }

  TIMES = -> n { -> f { -> x { n[f][x] } } }
  SUCC  = -> n { -> f { -> x { f[n[f][x]] } } }

  ADD       = -> m { -> n { -> f { -> x { m[f][n[f][x]] } } } }
  MULTIPLY  = -> m { -> n { -> f { m[n[f]] } } }
  POWER     = -> m { -> n { n[m] } }
  PRED      = -> n { -> f { -> x { n[-> g { -> h { h[g[f]] } }][-> y { x }][-> y { y }] } } }
  SUBTRACT  = -> m { -> n { n[PRED][m] } }

  # Booleans

  TRUE  = -> x { -> y { x } }
  FALSE = -> x { -> y { y } }
  IF    = -> b { b }

  NOT = -> b { -> x { -> y { b[y][x] } } }
  AND = -> a { -> b { a[b][a] } }
  OR  = -> a { -> b { a[a][b] } }

  # Natural numbers with booleans

  IS_ZERO           = -> n { n[-> x { FALSE }][TRUE] }
  IS_LESS_OR_EQUAL  = -> m { -> n { IS_ZERO[SUBTRACT[m][n]] } }
  IS_EQUAL          = -> m { -> n { AND[IS_LESS_OR_EQUAL[m][n]][IS_LESS_OR_EQUAL[n][m]] } }

  # Combinators

  Y = -> f { -> x { f[       x[x]     ] }[-> x { f[       x[x]     ] }] } # the famous one, for lazy languages like Haskell
  Z = -> f { -> x { f[-> _ { x[x][_] }] }[-> x { f[-> _ { x[x][_] }] }] } # eta-expanded Y combinator, for eager languages like Ruby

  # Natural numbers with recursion

  FACTORIAL = Z[-> f { -> n { IF[IS_ZERO[n]][ONE][-> _ { MULTIPLY[n][f[PRED[n]]][_] }] } }]
  DIV       = Z[-> f { -> m { -> n { IF[IS_LESS_OR_EQUAL[n][m]][-> _ { SUCC[f[SUBTRACT[m][n]][n]][_] }][ZERO] } } }]
  MOD       = Z[-> f { -> m { -> n { IF[IS_LESS_OR_EQUAL[n][m]][-> _ { f[SUBTRACT[m][n]][n][_] }][m] } } }]

  # Pairs

  PAIR    = -> x { -> y { -> f { f[x][y] } } }
  FIRST   = -> p { p[-> x { -> y { x } } ] }
  SECOND  = -> p { p[-> x { -> y { y } } ] }

  # Lists

  NIL     = -> f { -> x { x } }
  CONS    = -> x { -> l { -> f { -> y { f[x][l[f][y]] } } } }
  IS_NIL  = -> k { k[-> x { -> l { FALSE }}][TRUE] }
  HEAD    = -> k { k[-> x { -> l { x } }][NIL] }
  TAIL    = -> l { FIRST[l[-> x { -> p { PAIR[SECOND[p]][CONS[x][SECOND[p]]] } }][PAIR[NIL][NIL]]] }

  FOLD_LEFT   = Z[-> f { -> g { -> x { -> l { IF[IS_NIL[l]][x][-> _ { f[g][g[HEAD[l]][x]][TAIL[l]][_] }] } } } }]
  FOLD_RIGHT  = -> f { -> x { -> l { l[f][x] } } }
  MAP         = -> f { FOLD_RIGHT[-> x { CONS[f[x]] }][NIL] }

  RANGE   = Z[-> f { -> m { -> n { IF[IS_LESS_OR_EQUAL[m][n]][-> _ { CONS[m][f[SUCC[m]][n]][_] }][NIL] } } }]
  SUM     = FOLD_LEFT[ADD][ZERO]
  PRODUCT = FOLD_LEFT[MULTIPLY][ONE]
  APPEND  = -> k { -> l { FOLD_RIGHT[CONS][l][k] } }
  PUSH    = -> x { -> l { APPEND[l][CONS[x][NIL]] } }
  REVERSE = FOLD_RIGHT[PUSH][NIL]

  INCREMENT_ALL = MAP[SUCC]
  DOUBLE_ALL    = MAP[MULTIPLY[TWO]]

  # Natural numbers with lists

  TEN       = SUCC[MULTIPLY[THREE][THREE]]
  RADIX     = TEN
  TO_DIGITS = Z[-> f { -> n { PUSH[MOD[n][RADIX]][IF[IS_LESS_OR_EQUAL[n][PRED[RADIX]]][NIL][ -> _ { f[DIV[n][RADIX]][_] } ]] } }]
  TO_CHAR   = -> n { n } # assume string encoding where 0 encodes '0', 1 encodes '1' etc
  TO_STRING = -> n { MAP[TO_CHAR][TO_DIGITS[n]] }

  # FizzBuzz

  FOUR    = SUCC[THREE]
  FIVE    = SUCC[FOUR]
  FIFTEEN = MULTIPLY[THREE][FIVE]
  FIZZ    = MAP[ADD[RADIX]][CONS[ONE][CONS[TWO][CONS[FOUR][CONS[FOUR][NIL]]]]]
  BUZZ    = MAP[ADD[RADIX]][CONS[ZERO][CONS[THREE][CONS[FOUR][CONS[FOUR][NIL]]]]]

  FIZZBUZZ =
    -> m { MAP[-> n {
      IF[IS_ZERO[MOD[n][FIFTEEN]]][
        APPEND[FIZZ][BUZZ]
      ][IF[IS_ZERO[MOD[n][THREE]]][
        FIZZ
      ][IF[IS_ZERO[MOD[n][FIVE]]][
        BUZZ
      ][
        TO_STRING[n]
      ]]]
    }][RANGE[ONE][m]] }
end
