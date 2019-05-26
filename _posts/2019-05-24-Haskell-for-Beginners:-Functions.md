---
layout: post
title:  "Haskell for Beginners: Functions"
date:   2019-05-24 00:00:04 +0100
categories: haskell tutorial
---

Functions, functions, functions; Haskell is all about functions.
When writing Haskell code we create, compose and apply functions to achieve our goal.


# What is a function
In Haskell a function takes one or more things (referred to as arguments), and will give you back something else (referred to as the output or return value).

So to recap, a Haskell function takes something and gives something else back. This is all a 'normal' function can do in Haskell, I will discuss the 'non-normal' functions, ones that can effect the program state later, they are more advanced.

# Kinds of Data
So we know what a function is, so what can I give it. In other words what types can the function accept.

Some commonly used data types defined in `prelude` (the standard Haskell library that is always available) are:
- `Int`/`Integer`
- `Float`
- `Char`
- `String`
- `Bool`

Just to be sure lets recap those data types, in Haskell it is very important to have a good understanding of types.

`Int`/`Integer` refer to whole numbers the only difference is the bounds of the number, the maximum and minimum it can be, this is due to memory allocation. The `Int` supports integers in the range [-2^29 ... 2^29-1], where as `Integer` is an arbitrary precision type, it can hold any number subject to the machines memory limitations.

A `Float` holds a decimal value. 

A `Char` hold a single character. 

A `String` holds multiple characters, in actual fact the `String` data type is actually a _Type Alias_ for `[Char]`, a list of character, we will be using this fact later in this series. 

Finally `Bool` which is a Boolean value which is a logical result either `True` or `False`.

As you discover _Algebraic Data Types_ you will find that the above list is in fact essentially infinite, I will cover this topic in detail in a later post.


# Applying a Function
Haskell gives us two ways of applying *Arguments* to a *Function*.

## Prefix Application
*Prefix* application is where the function name comes before the arguments. In Haskell to apply a function we don't bother with round brackets. 

```
sum [1,2,3]
-- sum ::  Num a => [a] -> a
-- Returns the sum of the list

max 4 19
-- max :: Ord a => a -> a -> a
-- Returns the largest of its two arguments
```

As you can see the function name is given before the arguments to this is a _Prefix_ application. Note the `--` above are used to give comments in a Haskell source code file.

## Infix Application
However, some functions would look strange if they was written in a _Prefix_ style. We have another option *Infix* application.

```
1 + 2
-- (+) :: Num a => a -> a -> a
-- Returns the sum of its arguments

True && False
-- (&&) :: Bool -> Bool -> Bool
-- Returns the result of the application of a logical 'and'
```

As you can see the function name is in between the arguments of the function.

However, sometimes we may want to write a infix function in a prefix style this can be done very easily, by enclosing it in round brackets.
```
(+) 1 2
-- (+) :: Num a => a -> a -> a
-- Returns the sum of its arguments

(&&) True False
-- (&&) :: Bool -> Bool -> Bool
-- Returns the result of the application of a logical 'and'
```
We may also want to write a prefix function in a infix function in a prefix style, this can be done by enclosing the function name in _back ticks_ ``.
```
4 `max` 19
-- max :: Ord a => a -> a -> a
-- Returns the largest of its two arguments
```

# Composing a Function
Know we know how to apply a function, we want to know how we can string functions together to achieve our goal.

```
square  :: Int -> Int
-- Returns the square of a number

cube    :: Int -> Int
-- Returns the cube of a number

largest :: Int -> Int -> Int
-- Returns the largest of two numbers

(cube 2) `largest` (square 3)
```
In the example above we have used `largest` in an infix style, because to me that makes the code easier to understand, both `cube` and `square` have both been used prefix because again that style makes the code easier to read in this situation.

The `largest` function has been composed with both `cube` and `square` the result of those calculations are given to the `largest` function (and evaluated when required, Haskell is [lazy](https://en.wikipedia.org/wiki/Lazy_evaluation)).

# Defining a new Function
Right enough reading, I think its about time we wrote some Haskell for ourselves.

1. Open your favourite text editor, I like to use *Emacs* I will be making a series about Emacs soon.
2. Create a file called `basic_functions.hs` all Haskell source code files will have the `.hs` file extension.
3. Lets now define the `square`, `cube` and `largest` functions.
4. We are using Haskell so *Types Matter*, although the *Haskell Type System can infer types* I always give a *Type Signature* for every function I define.
```
square :: Int -> Int
```
5. Now its time for the actual function, what we need the function to do is get a value and return its square. Lets use the power operator `(^)`.
```
square :: Int -> Int
square x = x^2
```
6. That's it, our first Haskell function, write the cube function then check your answer.
```
cube :: Int -> Int
cube = (^3)
```
7. Have you got the same? This is a new concept I have not introduced yet. This feature of Haskell is called *Partial Function Application*, its allows us to simplify the definition of functions, to essentially their logical/base components. Don't you <3 Haskell.
8. The `largest` function behaves identically to the `max` function, so why not use that.
```
largest :: Int -> Int -> Int
largest = max
```
9. The above is just example, in any other situation you might as well us the `prelude` function `max` and avoid  unnecessary definitions
10. Its time to test our new functions, open your favourate terminal emulator, move to the directory where the Haskell source code file is stored and enter `ghci basic_functions.hs`, this will load the file in to the _Glasgow Haskell Compiler Interactive_.
11. Now from the GHCI prompt, enter `cube 4` you should see the result `64` displayed directly in the terminal windows
12. Enter `square 9` you should see the result `81`.
13. Congratulations, you've just written your first Haskell code.


# Conclusion
I hope you've picked up some ideas about functions now, we will be building on these on later posts. The next post will be about a very cool Haskell feature _Lists and Comprehensions_, see you there.
