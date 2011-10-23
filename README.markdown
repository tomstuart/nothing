# Programming With Nothing

This code accompanies the [Ru3y Manor](http://rubymanor.org/3) talk “[Programming With Nothing](http://speakerdeck.com/u/tomstuart/p/programming-with-nothing)”.

The idea is to implement some basic data structures and control flow under the constraint of only being allowed to create and call procs.

## Getting started

All code uses the `->` syntax, so **Ruby 1.9 is required**.

If you are brave, the `challenge` branch has a set of pending specs and an empty implementation file. Can you make them all pass without breaking any of the rules? Use `bundle install` to set up RSpec, then just type `rspec` to run the specs. (To use autotest, run `gem install ZenTest` and then `autotest`.)

If you are afraid, the `story` branch contains a series of commits which fill out the implementation until all the specs pass.

## Rules

* Your code may create procs (with `Proc.new`, `Kernel.proc`, `Kernel.lambda` or `->`) and call procs (with `Proc#call`, `Proc#[]`, `Proc#===` or `Proc#()`).
* Aside from the above, you may not use any of Ruby's built-in classes, modules, methods, keywords or other language features.
* You may not assign to local variables.
* As a practical consideration, you must define constants in order to expose your implementations to the specs. You may also define and later refer to constants for the purpose of code reuse.
* Constant definition may not be used to sneak recursion in through the back door. A constant is not defined until you have finished defining it, so defining `FOO` in terms of `FOO` is cheating.

## Hints

* `DECREMENT` is hard, so you may need to [steal `PRED`](http://en.wikipedia.org/wiki/Lambda_calculus#Arithmetic_in_lambda_calculus).
* The evaluation of any proc-valued expression `e` can be deferred by writing it as `-> x { e[x] }` as long as it doesn't have any free variables called `x`. (This is [eta-conversion](http://en.wikipedia.org/wiki/Lambda_calculus#.CE.B7-conversion).)
* Self-application is the simplest way to define a recursive function without cheating. Instead of `FOO = ... FOO[...] ...`, try `BAR = -> f { ... f[f][...] ... }; FOO = BAR[BAR]`.
* The more complex [Y combinator](http://en.wikipedia.org/wiki/Fixed_point_combinator#Y_combinator) is a tidier way to define a recursive function, but in Ruby it loops forever; try the [Z combinator](http://en.wikipedia.org/wiki/Fixed_point_combinator#Other_fixed_point_combinators) instead.
* If you're already familiar with functional programming, beware that operation names and argument order have been chosen to be familiar to Ruby programmers, e.g. `UNSHIFT` (vs. `CONS`) takes a list as its first (vs. last) argument. If you are upset, see the `pedant` branch.

## Console

```ruby
$ irb -Ilib -Ispec -rsupport/helpers

>> include Nothing, Helpers
=> Object

>> to_integer(from_integer(42))
=> 42

>> to_boolean(from_boolean(false))
=> false

>> to_array(from_array([true, 9, :hello]))
=> [true, 9, :hello]

>> to_array(from_array([representation_of(3), representation_of(5)])).map { |n| to_integer(n) }
=> [3, 5]

>> to_integer(ADD[TWO][THREE])
=> 5
```

## Legal

Copyright 2011 Tom Stuart (<tom@experthuman.com>, [@tomstuart](http://twitter.com/tomstuart)). This is free software; see COPYING for details.
