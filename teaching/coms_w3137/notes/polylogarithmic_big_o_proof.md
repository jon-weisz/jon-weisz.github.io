---
title: "Polylogarithmic Big O Proof"
layout: teaching_page
author: jon_weisz_columbia
---

We want to prove that:


 > log<sup>c</sup>(x) = O(x)
 >  
 > or
 >     
 > &#398;x<sub>0</sub>,c   s.t.   log<sup>c</sup>(x) &#x2264; cx &#8704;x >x<sub>0</sub>

However, it is actually easier to prove an even stronger relation which we didn't discuss in class known as Little-o.


#Little-o
[From Wikipedia](http://en.wikipedia.org/wiki/Big_O_notation#Little-o_notation):
 
> The relation \\( f(x) \in o(g(x)) \\) is read as "\\(f(x)\\) is little-o of \\(g(x)\\)". Intuitively, it means that \\(g(x)\\) grows much faster than \\(f(x)\\), or similarly, the growth of \\(f(x)\\) is nothing compared to that of \\(g(x)\\).   It assumes that f and g are both functions of one variable. Formally, \\(f(n)=o(g(n))\\) as \\(n\to\infty \\) means that for every positive constant \\( \epsilon \\) there exists a constant \\(N\\) such that: <br>
> <br>
> \\( \|f(n)|\leq\epsilon|g(n)|\qquad\text{for all }n\geq N~ \\) . <br>
><br>
>Note the difference between the earlier [...] big-O notation, and the present definition of little-o: while the former has to be true for *at least one* constant *M* the latter must hold for *every* positive constant \\(\epsilon\\), however small.<ref name="Introduction to Algorithms"/> In this way little-o notation makes a stronger statement than the corresponding big-O notation: every function that is little-o of *g* is also big-O of *g*, but not every function that is big-O *g* is also little-o of *g* (for instance *g* itself is not, unless it is identically zero near ∞).
>
>If *g*(*x*) is nonzero, or at least becomes nonzero beyond a certain point, the relation *f*(*x*)&nbsp;=&nbsp;*o*(*g*(*x*)) is equivalent to:  
>
>\\(\lim_{x \to \infty}\frac{f(x)}{g(x)}=0.\\)

This definition tells us that to establish our proof, we need only establish that final stage:

> \\(lim_{x \to \infty}\frac{ln^c(x)}{x}=0 \\)

which turns out to be trivial, if we remember early calculus.

#L'Hôpital's Rule
[From Wikipedia](http://en.wikipedia.org/wiki/L%27H%C3%B4pital%27s_rule)

> In its simplest form, L'Hôpital's rule states that for functions *f* and *g* which are differentiable on an open interval *I* except possibly at a point *c* contained in *I*: 
>  
>If \\(\lim\_{x \to c} f(x)=\lim\_{x \to c}g(x)=0 \text{ or } \pm\infty \\) , and
><br>
><br>
>\\(\lim\_{x\to c}\frac{f'(x)}{g'(x)}\\) &nbsp; exists, and
><br>
><br>
>\\(g'(x)\neq 0\\) for all *x* in *I* with \\(1=x ≠ c\\),
><br>
><br>
>then
><br>
><br>
>\\(\lim\_{x\to c}\frac{f(x)}{g(x)} = \lim\_{x\to c}\frac{f'(x)}{g'(x)}\\).
>
>The differentiation of the numerator and denominator often simplifies the quotient and/or converts it to a limit that can be evaluated directly.

Since \\(\lim\_{x\to\infty}log(x)=\infty \text{ and } \lim\_{x\to\infty}x=\infty\\), we can apply this rule, along with the chain rule to solve the proof

#Application of the Chain Rule
To apply L'Hôpital's Rule we must be able to take the derivative of both the numerator \\(f(x)=log^{c}(x)\\) and the denominator \\(g(x)=x\\) independently. The derivative of the denominator, \\(g'(x)\\), is trivially *1*. The derivative of the numerator must be derived using the [Chain Rule](http://en.wikipedia.org/wiki/Chain_rule)  

>\\( f(g(x))\' = f\'(g(x)) * g\'(x) \\)  
<br>
i.e.  
\\( clog^{c\-1}(x) * \frac{1}{x}  = c\frac{log^{c\-1}(x)}{x}\\)
<br>

Which leaves us with the exact same problem with an additional multiplicative factor with the exponent *C* decremented by 1.

Applying the same definition recursively C times, we end up with:  

> \\(\lim\_{x\to\infty} \frac{C!}{x}\\) = 0
> <br>
<br>

Since C! is a constant

Which fulfills the requirements for "little-o"  and therefore satisfies the requirements of a "Big O".  QED. 






