---
title: "Recursion"
date: 2019-05-29
lastmod: 2020-05-12T18:18:16+01:00
tags: ["Programming", "Tutorial", "Haskell"]
categories: ["Haskell for Beginners"]
draft: false
weight: 2006
---

Our research into <span class="underline">Haskell  Lists</span> continues.
Before we can look into using recursive functions with lists, I think first we need to cover what recursion is.
In my opinion recursion is one of the most important concepts for any <span class="underline">Functional Programmer</span>.

> Recursion: Where a function calls its self from within its definition.

<!--quoteend-->

> Case: A condition that could happen, eg the number could be zero or it may not be.

Lets kick off with an example of a recursive example then I'll work through it with you. Keep in mind the definitions of **recursion** and a **case** from above.

```haskell
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

Above we have an example of using recursion to find the factorial of a number. I have also added a **multi-line comment** (using the `{-COMMENT-}` syntax) to show how the **lazy evaluation** of an expression occurs in Haskell.


## Base Case {#base-case}

The base case is the most important aspect of any recursive function, this is where the recursion ends (the program doesn't call its self in this case).
We are always computing to get to the base case, in the above example, we are decreasing the number that is passed in the the `factoralRec` function by one each time.
We then reach the **Base Case** `factoralRec 0 = 1` - this is where the recursive calls stop and the program can begin to **unwind**, the theory behind recursion can be quite complex for a beginner but read [here](https://en.wikipedia.org/wiki/Recursion%5F(computer%5Fscience)) for more information.


## Recursive Call {#recursive-call}

Alas,  we may have the best base case but any <span class="underline">recursive</span> function still needs a **recursive call**, the is where the function calls it self.
You can see this in the line `factoralRec x = x * factoralRec (x-1)`, this may seem complicated at first.
I was also initially confused, I used to ask myself, '_how does the compiler know what the function is if its used in its own the definition?_'.

After the code I have shown how the evaluation would occur, I have omitted some brackets to make it easier to understand, as the bracketing doesn't matter with this function.
I hope this makes the recursive step easier to understand.


## Conclusion {#conclusion}

This has been a <span class="underline">quick and dirty</span> introduction to <span class="underline">Recursion</span>, in the next post I will be covering how we can use this new knowledge with particular applications to list.
