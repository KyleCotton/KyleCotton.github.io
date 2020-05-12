# Understanding Haskell Documentation


In this post I will be giving an insight in reading haskell documentation


## Product Example {#product-example}

```haskell
product :: Num a => [a] -> a
-- The product function computes the product of a finite list of numbers.
```

Above is an extract from the Haskell documentation.

Line 1 shows the ****Type Signature**** of the product function, this shows the types of the inputs and the outputs in a convenient way.

All functions in Haskell return a single object, this could be a single number, tuple, list etc. The first part of this statement `Num a` is called a ****Type Class**** this is a more advanced topic and something we will discuss later.

The final part of the statement `[a] -> a` this  is showing a list of something is given to the `product` function and a single something is returned. The type of the something must be a `Num` as it is stated in the ****Type Class****.


## Appending Two Lists {#appending-two-lists}

```haskell
(++) :: [a] -> [a] -> [a]
-- Append two lists
```

Above is an extract from the Haskell documentation.

Again line 1 shows the ****Type Signature**** of the append operator. We know haskell returns only a single object so we know what the final `[a]` represents that means that the first two `[a]` must be the inputs to the function. So this function takes two lists of the same type (both are parameterised with a) and  returns a new list  of the same type of the input.

