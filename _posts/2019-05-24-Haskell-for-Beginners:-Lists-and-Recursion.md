---
layout: post
title:  "Haskell for Beginners: Lists and Recursion"
date:   2019-05-30 00:00:07 +0100
categories: haskell tutorial
---

Now you know a little about _Recursion_ its time we use this knowledge for good - lets use it with a _Haskell Favorite, Lists!_

# How the list is built
I've spoken about the *List Data Type* previously in the **Haskell for Beginners: Lists and Comprehensions** post, but we need to know a little more about them before we can apply our newly found recursive knowledge to them.

**A list is build not made**, let me explain. Every list is build using only `:`, 'cons' and `[]` the empty list.
```
-- Note: This is not valid Haskell code
--         only the representations as
--         lists are accurate.

[1,2,3] = 1:(2:(3:[]))

"list"  = [’l’,’i’,’s’,’t’] = ’l’:(’i’:(’s’:(’t’:[])))
```
The above may look complicated, but lets go through it. A very important thing to remember for later is that the _Base_ of any list is the **Empty List** `[]`.
From here we append elements onto the list using the 'cons' (short for construct) `:` operator.

The _Type Signature_ of gives a clear picture of what the operator does `(:) :: a -> [a] -> [a]`, if your unsure how to interpret this signature check out the **Haskell for Beginners: Understanding Haskell Documentation** post, which covers this in detail.

# Pattern Matching
The last thing we need to know is pattern matching, this allows us to split a list if it *matches a pattern*, lets look at an example to make things easier to understand.

```
patternMatch :: [a] -> String
patternMatch (_:_:_) = "List with at least 2 elements"
patternMatch (_:_)   = "Non-Empty List"
patternMatch []      = "Empty List"
```

Above we have a nice example of pattern matching in action.

Note, the `_` character matches with anything, we use this if we don't care what the actual value is, it allows for compiler optimization. I'll give an example using the values from a pattern match a little later.

Let me now go through each pattern and describe what it means.
- `[]` - Use this statement if the input is the empty list.
- `(_:_)` - Use this statement if there is at least one element in the list. This is because the final `_` may be the empty list, but it may contain any number of elements or it could even be infinite.
- `(_:_:_)` - This pattern is very similar to the one above, but it allows us to say this list contains at least two elements.
- We can pattern match any finite number of elements from a list (if you want to type out the pattern :-)  ).

I advise you copy and play about with this example, you will notice that the order of the expressions does indeed matter. Haskell will use the first available pattern that matches so if we swapped lines two and three, then this statement `patternMatch (_:_:_) = "List with Two+ Elements"` would be redundant.

Note, we are using a _Polymorphic Type, 'a'_, we will be covering this when we go through *Type Classes*. 

Note, the last line `patternMatch [] = "Empty List"`, is not strictly a pattern match, but it is required.

If you omit that line and then try to evaluate, `patternMatch []` you will get an error, `Exception: Non-exhaustive patterns in function patternMatch`. 
This means there is a **case** that we have not considered, so when Haskell trys to replace it, it doesn't know what to replace it with and has no choice but to raise an exception.

As you will find out, if you program in a correct _functional_ way _run time errors_ will be extremely rare.

Pattern matching can also be used to extract elements from a list, lets run through a quick example of how this would work.

```
patternMatch :: (Show a) => [a] -> String
patternMatch (x1:x2:xs) = "First Element: "     ++ show x1 ++
                          " Second Element: "   ++ show x2 ++
                          " Rest of the List: " ++ show xs
patternMatch (x:xs)     = "First Element: "     ++ show x ++
                          " Rest of the List: " ++ show xs
patternMatch []         = "Empty List"
```

The biggest change in this version of the code in terms of the _pattern matching_ is that we have now name the elements of the pattern, where before we used `_` now we have used variables, `x1`,`x2`,`x`,`xs` in this particular example. This allows us to extract elements from the list.

In the above example I have used a new function `show`, so lets go through it.
```
class Show a where
  ...
  show :: a -> String
  ...
  	-- Defined in ‘GHC.Show’
```
Using _ghci_ we get the following _info_, you know how to read this from the  **Haskell for Beginners: Understanding Haskell Documentation** post. The function takes an input of any type (that can be showed, this related to _Type Classes_ which we are discussing later), and returns a `String` version of it.

Here are some example of show:
```
Prelude> show 4
"4"

Prelude> show True
"True"

Prelude> show [1,2,3]
"[1,2,3]"
```

The `++` operator just combines two lists returning a new list.

## Examples
Now we've got the background knowledge, lets run through some examples. 
I may introduce some more exciting functions as we go along.
I will also take you through my thought process as I come up with a solution.

- Create a recursive function list that gives us all of the positive even numbers from a list.
  - When creating a recursive function, we first need to think about the base case. In this example that is the empty list, when the empty list is input the empty list should be returned.
  - Now we need to think about the recursive step, we have to select only the even numbers so we will have to use a guard, this will be done in conjunction with a *pattern match*
    - If the number is a even number it must be added to the list. We must continue checking the rest of the list till we reach the empty list the base case.
	- If the number is odd we ignore it and continue with the rest of the list.
  - So the final function could be something like below. When we use guards in functions they are represented with a pipe `|`, the otherwise statement will always be used if none of the above cases are met. You don't have to use the `otherwise` however, I **heavily recommend** it since it will avoid the dreaded `Exception: Non-exhaustive patterns in function evenList` error.

```
evenList :: [Int] -> [Int]
evenList [] = []
evenList (x:xs) | even x    = x : evenList xs
                | otherwise =     evenList xs
```

	
- Create a function that returns the square of all of the elements in a list.
  - First we always consider the base case. Again this will be the empty list, which will just return the empty list.
  - Now we think about the recursive step
    - All we need to do for the recursive step is go through and square all of the elements until we reach the base case (the empty list).
  - So the final function could look something like this.

```
squareRec :: [Int] -> [Int]
squareRec [] = []
squareRec (x:xs) = x^2 : squareRec xs
```

- Find the product of the square of all the numbers in a list.
  - This problem is slightly different, unlike the _List Comprehension_ method where we get the list then find the product in this example it will be easier to do it all in one function.
  - As always lets consider the base case, here when we get the empty list we must return an integer. When we get the empty list we must return `1` as this is the identity for multiplication. Just like `0` is the identity for addition.
  - Now lets consider the recursive step.
    - We need to get the element out of the list, we can use pattern matching to do this.
	- We then need to square this element
	- Then we need to multiply it my the result of the rest of the list going through the same process, this is the recursive part.
  - So the final function could look something like this.

```
squareProdRec :: [Int] -> Int
squareProdRec []     = 1
squareProdRec (x:xs) = x^2 * squareProdRec xs
```

- Define a function that takes a `String` argument and returns a `String` containing only the letters of the input but now all lowercase.
  - From one of my previous post I said a `String` is a *Type Alias* for `[Char]`. We are going to have to use this fact to answer this question.
    - We will treat the `String` as a list of `Char`, so that we can recurse over it.
  - The first thing we need to consider is the base case this will be the empty list, inputting the empty list should return the empty list.
  - Now the recursive step, we have two cases, the `Char` is a letter and it is not a letter. We will have to use guards.
    - If the `Char` is a letter (`isLetter` returns `True`), then we apply the `toLower` function, add it to the resulting list and continue with the rest of the list until we reach the empty list, out base case.
	- If the `isLetter` returns `False` we ignore it and continue with the rest of the list.
  - So the final function becomes

```
import Data.Char

lowerLetterRec :: String ->  String
lowerLetterRec [] = []
lowerLetterRec (x:xs) | isLetter x = toLower x : lowerLetterRec xs
                      | otherwise  =             lowerLetterRec xs
```

# Conclusion

Well there you have it another way of messing with lists. 
Isn't recursion in Haskell great!
In the next post we will be covering one of my favorite topics, **Haskell for Beginners: High Order Functions**.
See you in the next post, Kyle out!
