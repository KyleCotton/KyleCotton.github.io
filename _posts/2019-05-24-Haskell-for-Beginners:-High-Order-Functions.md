---
layout: post
title:  "Haskell for Beginners: High Order Functions"
date:   2019-06-22 00:00:08 +0100
categories: haskell tutorial
---

I've got a good post in store today, **High Order Functions**, one of my Haskell favourites.
We've previously covered, *List Comprehensions* and *Recursion* for getting stuff done in Haskell,
now we will be covering a slightly more advanced topic, but one I find very cool.

# Why so high?
You might be asking yourself, why these functions are so high?
I'll first explain what exactly is a high order function as you may have not encountered them before.
A high order function is a function that has an argument that is its self a function and or returns a function. 
That's it, simple isn't it. Keep reading to see a little of what we can do with them.

# Partial Function Application
Before we can get stuck into the *High Order Function* I'm going to explain another Haskell favourite - *Partial Function Application*.
This is where one or more of the function arguments are omitted when the function is used or applied.
An easy way of thinking of this is that that any arguments that are passed are then embedded in the result, we the function result only requires the remaining arguments.
As always lets have a look at I'll give an example of this below, this is one of the more complex examples we have looked at so far.

Below you can see the function I have defined, lets look into how *Partial Function Application* works using this as an example.
```
addSome :: Int -> Int -> Int -> Int
addSome x1 x2 x3 = x1 + x2 + x3
```

Using `GHCI` in a terminal, we can investigate this a little more.
```
GHCI> addSome 1 2 3
6
GHCI> let x = addSome 1 2
GHCI> x 3
6
GHCI> x

<interactive>:18:1: error:
    • No instance for (Show (Int -> Int)) arising from a use of ‘print’
        (maybe you haven't applied a function to enough arguments?)
    • In a stmt of an interactive GHCi command: print it
GHCI> let y = addSome 10
GHCI> y 90 100
200
GHCI> :t x
x :: Int -> Int
GHCI> :t y
y :: Int -> Int -> Int
GHCI> :i x
```

The first example is just standard way function is used; just summing the three `Int` arguments that have been passed to it.
The second example is the first time we use *Partial Function Application*, here we have partially applied the first two arguments to the function.
Notice, when we try to evaluate `x` Haskell doesn't know how to show it us, because it is a function, you can see this from the *Type Signature* `x :: Int -> Int` so an error is raised, as seen above.

# Function Composition
Haskell has functions, it also has functions of functions and functions of functions of functions of ...
So lets look a little it how we can _Compose_ functions in Haskell.

To compose functions in Haskell we use the _Function Composition Operator_ `.`. This may seem strange syntax at first.
Lets look at some examples and see how we can use this to our advantage.

```
powerTwo :: Num a => a -> a
powerTwo   = (^2)

powerThree :: Num a => a -> a
powerThree = (^3)

somePower = powerTwo . powerThree
```

Above I have added some code, this is what we will be using to explore this a little further.

First notice, I have not included a *Type Signature* for the `powerSix` function; 
the type signatures are not required however, I **Strongly Recommend** you always add one in,
they can frequently ping up errors in the code that are due to an error in the programs logic, 
(something the computer cannot do for us).

Now you can see that we have composed the functions: `powerTwo` and `powerThree`.
Take a minute to think of what the result of this operation will be.
Remember back to Mathematics, we apply the right most function first then move to the left,
so in effect we have the function `(x^3)^2`.

Lets try evaluating some values and see if they are what we expect.
```
GHCI> somePower  1
1
-- (1^3)^2 = 1 

GHCI> somePower  2
64
-- (2^3)^2 = 64

GHCI> somePower  3
729
-- (3^3)^2 = 729

GHCI> somePower  4
4096
-- (4^3)^2 = 4096

GHCI> somePower  (-1)
1
-- ((-1)^3)^2 = 1

GHCI> somePower  (-10)
1000000
-- ((-10)^3)^2 = 1000000

GHCI> somePower  "Hello, World!"
<interactive>:99:11: error:
    • Couldn't match expected type ‘Integer’ with actual type ‘[Char]’
    • In the first argument of ‘somePower’, namely ‘"Hello, World!"’
      In the expression: somePower "Hello, World!"
      In an equation for ‘it’: it = somePower "Hello, World!"

-- The inferred *Type Signature* for the `somePower` function does not allow
--  for `String` types so an error is raised, as Haskell cannot handle it.
```

Above I have evaluated the `somePower` function with a range of value to see the result.
Hopefully I you know have a better understanding of how *Function Composition* work in Haskell
and how we can use it.

# Filter 
Now its time to get stuck into a few high order functions available in Haskell `Prelude`.
`Filter` is the first of these functions; `filter :: (a -> Bool) -> [a] -> [a]`,
the filter takes a *Predicate Function* and a *List* which returns a *List*.
Every item is passed to the predicate function those that evaluate to `True`are added,
the ones that evaluate to `False` are omitted.

This allows us to easily *filter* elements from any given list.
Lets look at an example of how we can use the filter function.

- Create a high order function that gives us all of the positive even numbers from a list. 
  - Thinking about this at a _higher_ level, we know we need only the positive even numbers
  - So lets `filter` these out into our result
  - we need a function that will return `True` when a positive even number is passed and `False` otherwise.

```
predicate :: (Integral a) => a -> Bool
predicate x = even x && x>0

posEven :: (Integral a) => [a] -> [a]
posEven = filter predicate

---------------------------------------------

posEvenNew :: (Integral a) => [a] -> [a]
posEvenNew = filter (\x -> even x && x>0)
```

Above you can see my solution to the problem; I have included two example solutions.
The first is more verbose, it has a separate predicate function that is then used in the final function.
The second example is much prettier, it uses *Lambda* functions, this is something we will be covering in the next post.

Both functions work in a similar manner, each of the value of the lists are passed to the predicate function; whether that be the separate `predicate` function or the *Lambda* function `\x -> even x && x>0`.
If the value returns `True` it will be added to the resulting list,
if the value returns `False` the item won't be added.

Both examples have used a *Type Class* this is because there are 
restrictions that need to be placed on the types of the input.
Looking at the types of the functions in the definition: 
`even :: Integral a => a -> Bool` and `(>) :: Ord a => a -> a -> Bool`
from this we can see we need to add the `Integral` *Type Class* to our function, 
this means that the type of our input has to either be a `Integer` or `Int`.
We don't need to include the the `Ord` type class as well because the `Integral` type class includes it.
You can check this be using `GHCI`: `:i Ord`, I'll leave this as an exercise for the reader,
remember we will be covering *Type Classes* fully later in this series.

# Map
The map function has the type `map :: (a -> b) -> [a] -> [b]`, its arguments are a function and a list.
The function is then applied to every item in the list; you can clearly see this from the type signature.

Lets run through an a few examples using the map function, I'll talk through them in the same way I did the in the recursion and list comprehension posts.

- Create a function that returns the square of all of the elements in a list.
  - When are using high order functions we need to think at a more logical 'higher' level.
  - Lets think what we have to do to each item, we have to square it.
  - So lets map across a squaring function
  - The final function should look something like what is noted below.
  
  
```
squareHi :: (Num a) => [a] -> [a]
squareHi = map (^2)
```

Notice the type signature; the type of the `^` operator:  `(^) :: (Integral b, Num a) => a -> b -> a`, 
we must add constraints to the type of our input otherwise we would get a type error, Haskell's favourite error.
This is achieved by using a *Type Class* `Num a` again I will be covering this later.
The *Haskell Type System* can also infer the type of the function however, this is not best practise - personally I always include a type signature.  
  
- Create a function that returns the logical  `and` of a list of `Int`. 
Each item is `True` if the number is greater than `5` otherwise `False`.
  - Thinking on a higher level, we know the same function (the one checking the vale) has to be applied to every value. Lets use the `map` function.
  - The function that needs to be applied doesn't exist in the standard library (to the best of my knowledge) so lets create our own version of it instead.
  - The final function and its helper could look like what is shown below.
  
```
greaterFive :: Int -> Bool
greaterFive x | x > 5     = True
              | otherwise = False

f :: [Int] -> Bool
f = and . map greaterFive
```

As always let me go through this example in a little detail, our functions are starting to get a little more advanced now.

The `greaterFive` function is the one that is mapped across each of the values in the list, it is applied to each of the values in the list. This will give us a list of `Bool` values which then has the `and` function applied to them.

Lets take note of the *Type Signatures*: 
`greaterFive`: `greaterFive :: Int -> Bool`, 
`f`: `f :: [Int] -> Bool`, 
`and`: `and :: Foldable t => t Bool -> Bool`; for the minute you can think of `Foldable` as a `List`.



# Fold
Now its time to fold. Lets look into how we can use the `foldr` function in Haskell to write some pretty code.

Let me take you back to when I first introduced the list I said **A list is build not made**.
Every list no matter the type of the elements will have this structure `[1,2,3] = 1:(2:(3:[]))`.
When we think about folding I like to keep this structure in the front of my mind.

`foldr` has the *Type Signature* `foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b`,
again think of `Foldable` and `t a` both as lists.
So the `foldr` function takes a function, a value and a list as its inputs.

Lets run through an example to see how we actually use this, 
in this example we will be rewriting the `and` function.

```
highAnd :: [Bool] -> Bool
highAnd xs = foldr (&&) True xs

foldr (&&) True [x1, x2, x3] = x1 && (x2 && (x3 && True))
```

Above we have an example of an implementation of the `and` function and how it would be evaluated.
Notice how similar this is to the structure of a list;
the cons operator `:` has been replaced with a binary operator (a function taking two arguments),
the `True` value is the identify for *logical and*, 
the same way that `0` is the identify for addition and subtraction
and `1` is the identify for multiplication and division,
the finally the list that this we will be working with.


```
GHCI> highAnd [True, True, False, True]
False
-- True && (True && (False && (True && True)))

GHCI> highAnd [True, True, True, True]
True
-- True && (True && (False && (True && True)))
```

Above we have a few examples of the function being evaluated.
As always lets run through some examples and I will describe how I would approach them.

- Find the product of all the numbers in a list.
  - We are thinking at a 'higher' level in this post.
  - We know that we want to have a single result in the end
  - So lets *fold* that list up then
  - In this example we are finding the product, lets think of the arguments to the `foldr` function
  - Binary Operator: (*), Identity: 1
  - The final function could look something like this
  
```
highProd :: Num a => [a] -> a
highProd = foldr (*) 1
```

This function folds in the multiplication operator into the list and uses `1` to be the identity fr this operation.

# Examples
I think its time we finally used all three of these together

- Create a high order function that gives us all of the positive even numbers from a list.
  - We are selecting elements from a list in this example, we are filtering certain elements.
  - We need to also create a predicate function that evaluated to `True`
for positive even numbers and `False` for the rest.
  - Something like this `\x -> even x && x>0` would work,
more on this in the next post.
  - We want the function to be able to take both 
`Int` and `Integer` types so lets also add a type class.
  - The final solution could look something like this.

```
a :: (Integral a) => [a] -> [a]
a = filter (\x -> even x && x>0)
```

- Create a function that returns the square of all of the elements in a list.
  - In this example we need to square all of the numbers in a list.
  - Since we are applying a function to all of the elements lets use `map`
  - We will need to apply the square function which with 
*Partial Function Application* we can write as `(^2)`
  - An example solution can be seen below.

```
b :: (Integral a) => [a] -> [a]
b = map (^2)
```

- Find the product of the square of all the numbers in a list.
  - This question is building on top of the previous.
  - After we have squared all of the elements in the list
we now need to find their product
  - We can do this by folding the list with the multiplication operator `*`.
  - The identify for multiplication is `1` so we will also need to use that.
  - Since we want to create a function, we will compose the `foldr` and `map`
parts of this question into a single function using the
*Function Composition Operator* `.`.
  - An example solution can be seen below.

```
c :: (Integral a) => [a] -> a
c = foldr (*) 1 . map (^2)
```

- Define a function that takes a `String` argument and returns a `String` containing only the letters of the input but now all lowercase.
  - In this example we need to do two things; remove all of the non-letters
and make everything lowercase
  - Lets first filter out all of the letters from our `String` 
this can be done be done by using the `isLetter` function 
found in the `Data.Char` library.
  - We then need to make all of these characters 
(remember Haskell treats a `String` as `[Char]`, a list of characters) lowercase
we can do this by using the `toLower` function again found in `Data.Char`.
  - After we have done this we will need to compose them using the `.` operator.
  - The final function could look something like the this.

```
import Data.Char

d :: String -> String
d = map toLower . filter isLetter
```

# Conclusion
Finally we have looked at the main ways of getting stuff done *Functionally* in *Haskell*; recursion, list comprehension and high order functions are all ready for us to use.

In the next post we will be looking at **Haskell for Beginners: Lambda Expressions**, we have used them a little in this post but I'd like to build on them further as I think they are very cool.
