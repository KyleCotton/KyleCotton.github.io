---
layout: post
title:  "Haskell for Beginners: Recursion"
date:   2019-05-28 00:00:06 +0100
categories: haskell tutorial
---

Our research into _Haskell  Lists_ continues. 
Before we can look into using recursive functions with lists, I think first we need to cover what recursion is.
In my opinion recursion is one of the most important concepts for any _Functional Programmer_.

> Recursion: Where a function calls its self from within its definition.

> Case: A condition that could happen, eg the number could be zero or it may not be.

Lets kick off with an example of a recursive example then I'll work through it with you. Keep in mind the definitions of *recursion* and a *case* from above.
```
factoralRec :: Int -> Int
factoralRec 0 = 1
factoralRec x = x * factoralRec (x-1)

{------------------------------------------
How the lazy evaluation occurs:
factoralRec 4
4 * factoralRec (4-1)
4 * factoralRec 3
4 * 3 * factoralRec (3-1)
4 * 3 * factoralRec 2
4 * 3 * 2 * factoralRec (2-1)
4 * 3 * 2 * factoralRec 1
4 * 3 * 2 * 1 * factoralRec (1-1)
4 * 3 * 2 * 1 * factoralRec 0
4 * 3 * 2 * 1 * 1
24
------------------------------------------}
```
Above we have an example of using recursion to find the factorial of a number. I have also added a *multi-line comment* (using the `{-COMMENT-}` syntax) to show how the *lazy evaluation* of an expression occurs in Haskell.

# Base Case
The base case is the most important aspect of any recursive function, this is where the recursion ends (the program doesn't call its self in this case).
We are always computing to get to the base case, in the above example, we are decreasing the number that is passed in the the `factoralRec` function by one each time. 
We then reach the *Base Case* `factoralRec 0 = 1` - this is where the recursive calls stop and the program can begin to *unwind*, the theory behind recursion can be quite complex for a beginner but read [here](https://en.wikipedia.org/wiki/Recursion_(computer_science)) for more information.

# Recursive Call
Alas,  we may have the best base case but any _recursive_ function still needs a *recursive call*, the is where the function calls it self. 
You can see this in the line `factoralRec x = x * factoralRec (x-1)`, this may seem complicated at first.
I was also initially confused, I used to ask myself, 'how does the compiler know what the function is if its used in its own the definition'. 

After the code I have shown how the evaluation would occur, I have omitted some brackets to make it easier to understand, as the bracketing doesn't matter with this function. 
I hope this makes the recursive step easier to understand.

# Conclusion 
This has been a _quick and dirty_ introduction to _Recursion_, in the next post I will be covering how we can use this new knowledge with particular applications to list.





