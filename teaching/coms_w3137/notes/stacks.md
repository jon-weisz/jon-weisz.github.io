---
title: "Stacks"
layout: teaching_page
author: jon_weisz_columbia
---
<iframe width="1280" height="750" src="https://www.youtube.com/embed/3sa9cXHGZHc" frameborder="0" allowfullscreen></iframe>  
  
<br>
  
<iframe width="1280" height="750" src="https://www.youtube.com/embed/iARwJeZI2EM" frameborder="0" allowfullscreen></iframe>  
  
<br>  
  
<iframe width="1280" height="750" src="https://www.youtube.com/embed/2pM9CxC21yw" frameborder="0" allowfullscreen></iframe>  
  
<br>  
  
<iframe width="1280" height="750" src="https://www.youtube.com/embed/TgnUFan6iwg" frameborder="0" allowfullscreen></iframe>  
  

## Outline
 * Introduction to Stacks
 * Implementations
 * Postfix Notation
 * Infix to Postfix conversion
 * Program Stacks

##Introduction to Stacks
  * Stacks are First in Last Out 
  * The following animations are courtesy of Dr. Galles at University of San Francisco[^1]
  ![Stacks](http://upload.wikimedia.org/wikipedia/commons/9/9f/Stack_data_structure.gif)
  * [Stack collection object](http://docs.oracle.com/javase/7/docs/api/java/util/Stack.html)
    * Extends Vector (List like Collection)
    * Semantics: 
      * pop() - Remove top from stack and return it
      * push(E) - Add e to top of stack 
      * peek() - look at top 	
      * search(E) Returns *1* based position of object. (How many pops to get it).

    * Generally speaking, we only use push(E) and pop.    

##Implementations

  * Linked list implementation

  <iframe src="http://www.cs.usfca.edu/~galles/visualization/StackLL.html" width="600" height="600"></iframe>

  * Array implementation

   <iframe src="http://www.cs.usfca.edu/~galles/visualization/StackArray.html" width="600" height="600"></iframe>

## Usages
  * Stack machines are simple to describe, yet very powerful
    * What do stacks remind you of?
      * Recursion!
      * Any recursion based algorithm is an implicit stack based algorithm. 

<br>
<br>

<iframe src="http://www.cs.usfca.edu/~galles/visualization/RecFact.html" width="600" height="600"></iframe>

###Postfix Notation

   This section is taken from the lecture series of B. Brown[^2].

  * Postfix is an alternate way of representing arithmetic formulae.
    * (Operand 1)(Operand 2)(Operator)
    
    * No parenthesis are ever required.
    * Easy to parse using a stack.
      * Divide the input into units of meaning - Tokens
      * Read from left to right, one token at a time.
      * Variables or constants are pushed on to the stack
      * When an operator is encountered, two tokens are popped from the stack
      * Operator is applied to two tokens, result is pushed back on to stack. 
    


<div style="width:320px;height:270px;overflow:hidden;position:relative;">

<iframe src="http://bbrown.spsu.edu/web_lectures/postfix/" style="position : absolute;
    top      : -900px;
    left     : -100px;
    width    : 1280px;
    height   : 1200px;"></iframe> 
</div>

<br>
<br>

  * Converting traditional infix to postfix can also be done with a stack!
    * Nearly the opposite of interpreting postfix
      * Numbers or variables copied directly to output
      * Left parenthesis always pushed on to stack
      * If a right parenthesis is encountered, the top of the stack is popped off the stack and placed in output. Repeat until a left parenthesis is encountered. Discard both parenthesis.
      * Otherwise, if input symbol has a higher priority than the one at the top of the stack, push it on to the stack. 
      * If the input symbol is lower priority or equal priority, pop the stack until a lower priority symbol is found. 
      * If end of input is reached, pop all items in stack.

<div style="width:440px;height:285px;overflow:hidden;position:relative;">

<iframe src="http://bbrown.spsu.edu/web_lectures/postfix/" style="position : absolute;
    top      : -1270px;
    left     : -100px;
    width    : 1280px;
    height   : 1800px;"></iframe> 
</div>

<br>
<br>

# Program Stacks[^3]
  * Modern computers explicity support langauges with function calls
  * Local variables for each function call are stored on the stack.
  * For each function context, as stack pointer points to the top of the stack. 
  * The stack grows DOWNWARDS in the address space as functions are called, meaning the stack pointer decreases. 
  * Local variables are stored relative to another pointer to a region of the stack, the frame pointer.
  * When a function is called, it saves the previous frame pointer somewhere, then advanceses the stack pointer and sets the frame pointer to the previous stack pointer.  
  

  * OK, so what?
    * Imagine argv[0] is read into some string S.
    * Imagine the size of c is 12, and argv[0] is 20 characters long
    * And no one checks the size of the input.
      * Not possible in Java, but in C or C++, it is!

<div style="width:1200px;height:620px;overflow:hidden;position:relative;">
<iframe src="http://en.wikipedia.org/wiki/Stack_buffer_overflow#Exploiting_stack_buffer_overflows" style="position : absolute;
    top      : -120px;
    left     : -100px;
    width    : 1280px;
    height   : 1800px;"></iframe> 
</div>


###A scarier example

<script src="http://pastebin.com/embed_js.php?i=HtEjf2v9"></script>

[Now what happens?](http://www.sagerock.com/blog/wp-content/uploads/2013/01/wpid-2534763-2510067-hulk.jpg)
<br>
<br>
<br>
<br>

<iframe width="854" height="510" src="https://www.youtube.com/embed/j-v7PHG_q2g" frameborder="0" allowfullscreen></iframe>

<br>
<br>

 * Because the stack grows down... You write over other variabler, or over variables in a function higher up (earlier) in the stack frame, or right over the return pointer, or... too many possibilities to count. 
   * This is called Smashing the Stack
   * It is a very major source of bugs and security exploits.
   * Note the example in the video is just a normal buffer overflow exploit - It doesn't actually overwrite the return pointer, but it illustrates the principle nicely. 
   


[^1]: http://www.cs.usfca.edu/~galles/visualization/
[^2]: ["Brown, B., (2001). Postfix Notation Mini-Lecture. Retrieved on 2015/2/4"](http://bbrown.spsu.edu/web_lectures/postfix/)
[^3]: http://insecure.org/stf/smashstack.html
