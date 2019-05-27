---
layout: post
title:  "Haskell for Beginners: Lists and Comprehensions"
date:   2019-05-27 00:00:05 +0100
categories: haskell tutorial
---

Welcome back to the next post now we will be learning about _List and comprehensions_, they form a large part of a typical Haskell program, so lets find out more about them now.

# The List
```
nums :: [Int]
nums = [1,2,3]

chars  :: [Char]
chars  =  ['h', 'a', 's', 'k', 'e', 'l', 'l']

str  :: String
str  =  "haskell"

funcs :: [[Int] -> Int]
funcs = [product, sum]

evenList :: [Int]
evenList = [0,2..100]
```

Haskell loves lists! Due to the _Type System_, all list can only contain elements of the same type.

Haskell also allows for infinite lists. An example of this can be seen below, I have extended the definition above to include all the even numbers - cool right! However, when we use infinite lists we have to ensure that we write robust code, so that we know our programs will eventually terminate. This will become even more important when we talk about recursion.

```
evenList :: [Int]
evenList = [0,2..]
```

## Basic List Operations
Now we know about the list, lets look into some basic functions that can be applied to a list.
This list shows us some of the most common functions, that are typically used with a _List Comprehension_
- `product` - returns the product of all the numbers in a list
- `sum` - returns the sum of all the numbers in a list
- `and` - applied a logic 'and' to the values in a list and returns the result
- `or` - applied a logic 'or' to the values in a list and returns the result
- `!!` - the infix direct access operator, returns the element at the nth position of the list
- Plus a lot more. Check out [Hoogle](https://hoogle.haskell.org/), for a list of functions.

Now lets see some examples of how these functions are used.

`product [1,2,3,4,5]` will return the value of `1*2*3*4*5` which is `120`.

`sum [1,2,3,4,5]` will return the value of `1+2+3+4+5` which is `15`.

`and [True,True,False,False,True]` will return the value of `True && True && False && False && True`which is `False`. Since there exists a `False` within the list.

`or [True,True,False,False,True]` will return the value of `True || True || False || False || True`which is `True`. Since there exist a `True` within the list.

`[0,2..100] !! 10` will return the element of the list `[0,2..10]` that is in the `10`th position. **Warning** , remember that list in Haskell and  most programming languages are **Zero Indexed**, we start counting from zero not one.


# List Comprehensions

Now we have the background knowledge its time we learn some *List Comprehensions*

I like to think of a list comprehension in exactly the same way I think about _Set Notation_ from mathematics.
I'm going to show the various part that make up a list comprehension.

```
[x | x <- [1..10], odd x]

-- [x | This part of the list comprehension shows us what
--      is added to the resulting list for each element
--      of the generating list.
	 
--      x <- [1..10] This part of the list comprehension
--                   is called the generator. It gets
--                   the elements from the generating
--                   list.

--        <- This is the 'drawn from' operator.

-- 	             , odd x] This final part of is known
--                            as the guard, it almost like
--                            an if statement. The element
--                            is added only if this is true.
```

The above may look complicated but that is more of the formal introduction to *List Comprehensions*. 

## Examples
Now lets run through some examples. I may introduce some more exciting functions as we go along.
I will also take you through my thought process as I come up with a solution.

- Create a list comprehension that gives us all of the positive even numbers.
  - So the answer needs to choose only the even numbers, so we will be needing a guard for even numbers. We will have to use the `even` function.
    - Lets find out more *info* about the even function.
    - Open `ghci` as you have done previously
	- Enter `:info even` this can also be shortened to `:i even`.
	- Take note of the type, we give it an `Integral` which is either a `Int` or `Integer` and it returns a `Bool`
	- This is exactly what we want, so lets use this handy function.
  - We want **all** of the positive even numbers so we are going to have to use an infinite list. This is the generator.
  - We don't need to apply any function to the number that is added from the generator.
  - So the final List Comprehension becomes the one below.

```
[x | x <- [0,2..], even x] 
```
- Create a list of the first 100 perfect squares.
  - When creating this list we can either, check if a number is a perfect square using a guard then add it, or create the perfect squares ourselves. I personally think the latter is easier.
  - So we won't be needing any guards for this solution.
  - The generator should give us all of the first 100 integers so that we can make them into the perfect squares.
  - We will need to apply a functions to each of the values, we need to square them.
  - So the final List Comprehension becomes the one below.

```
[x^2 | x<-[1..100]]
```

- Find the product of the first 100 perfect squares
  - This problem would be very complicated to solve without the aid of a computer.
  - We will be composing a previous solution with one of the list functions we introduced earlier in this post.
  - We already have list of the first 100 perfect squares, now we need to get the product of all of them.
  - Lets get more *info* about the `product` function
    - Lets open `ghci`
	- Enter `:i product`
	- Note the function takes a list of numbers and returns a single number
	- This is exactly what we want, lets use the product function
  - So the final List Comprehension becomes the one below.

```
product [x^2 | x<-[1..100]]
```

- Define a function that takes a `String` argument and returns a `String` containing only the letters of the input but now all lowercase.
  - From one of my previous post I said a `String` is a *Type Alias* for `[Char]`. We are going to have to use this fact to answer this question.
  - We have to only add characters that  are letters so we are going to have to use a guard. Lets find out more *info* about the `isLetter` function.
    - As previously use `ghci` to get more information about the function
	- We can see that the function takes a `Char` and returns a `Bool` this is perfect for what we want
   - We are given a string so that must form part of the generator
   - Finally we must make all of the characters lowercase, so we must apply a function to each of them. Lets look at the `toLower` function
     - Again use `ghci` to get more *info*
	 - We see that the function takes a `Char` and returns a `Char` this is what we want
	- So the final list comprehension becomes

```
f :: String -> String
f xs = [toLower x | x<-xs, isLetter x]
```

The above is a more complex example, lets go through the main parts of it again for clarity.

For this problem we have defined a function `f` that takes a `String` as input and returns a `String`. 
The input string is the `xs` on the left hand side of the _assignment operator '='_. 
We go through each element of `xs` which has type `[Char]`, we call this element `x`. 
First we check if it is a letter, if `False` it is discarded, if `True` we apply the `toLower` function, making it lowercase then add it to the list to  be returned.

# Conclusion

I hope this post has been beneficial. There are many situations in which list comprehension can massively simplify problems that you will face so always keep them in mind. In the next post I will be covering Lists and Recursion. Kyle out!



