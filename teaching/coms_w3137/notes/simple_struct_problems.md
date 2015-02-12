---
title: "Problem Solving"
layout: teaching_page
author: jon_weisz_columbia
---


#Strategies

These hints are taken from [Cracking the Coding Interview](http://www.amazon.com/Cracking-Coding-Interview-Programming-Questions/dp/098478280X#),
which has a great chapter on quickly breaking down problems. 

1. Create an example
  * Example problem: Given a time, calculate the angle between the hour hand and the minute hand.
	* Start with a diagram of the problem
	* Work out a heuristic


2. Pattern Matching
  * Example problem: Given a sorted array that may have been "rotated" so that the indices of the rotate array are mod(original_indices + offset, array_size), find the minimum element.
    * Example array: [3 4 5 6 7 1 2] 
    * What is similar to this problem?


    * Find the minimum element of a normal array
	* Find the minimum element of a sorted array
	* This problem is somewhere between

	* Finding the minumum element in a normal array is O(N), so that is the worst case scenario
	* Binary search?


	  * Could still work with adaptations.
		* Minimum element is either at the front or it is somewhere in the middle. If it is in the middle somewhere, the right must be less than the left side. 
	    * What about the middle element?


                  {2 3 4 5 6 7 1}

                  {7 1 2 3 4 5 6}

        * If it is greater than the left element, the minimum must be between the left element and the middle.
		
		* If it is greater than the left element, it must be between the right element and the middle. Repeat.
		
	    * Obviously, like binary search this is O(log(N))


3. Simplify
  * Throw out some constraints and see if you can solve the problem.
  * Example problem: Build a ransom note from a magazine.

	![Word ransome note](http://www.editorsweblog.org/sites/editorsweblog.org/files/imagecache/default_col_4/field_blog_entry_image/ransomnote-thumb-240x240-2929_0.jpg)

	* Given a sentence and a set of words, see if you can build the sentence out of the give words.

	* Simplification: Given a set of letters, can we build the sentence?

	* Start with a 26 member array. Count the letters in the sample, put them in the appropriate place in the array.
	
	* Go through the target sentence and subtract the appropriate character until you reach the end of the sentence or hit a 0 in the array.
	
	* Is there an analog of an array of characters for whole words?
   	  * Yes, dictionaries, we will cover them later.

  
4. Inductive solution

   * Define a solution for a base case
   
   * Figure out how to reduce your problem to the base case.
   
   * Example: Print out all permutations of a string.
	 * abcdef
	 * base case - length 1 "a"
	 * inductive step - length 2 "ba" "ab"
	   * Store the characters as linked list.
	   * For each character you are adding, duplicate the list n times.
	   * For each list i = 1 ... n, insert the new character in position i  
	   
	 * Obviously this approach lends itself to recursive solutions.

5. Datastructure brainstorming
  * Given a problem with less structure, just keep applying data structures until one fits. 
  * Not so applicable to this class, since we usually direct you to use a particular data structure. 

#Stacks, Queues, and Linked Lists

[The following problems are taken from Coders Maze](http://codersmaze.com/data-structure-and-algorithms-questions/stacks-and-queues-questions/)

## Redundant Brackets
Remove the redundant brackets from a mathematical expression.
e.g. input: (a + (b*c)) * (d * ( f * j) )
output should be: (a + b * c) *d * f * j
Solution:
Assumptions:

1. String is properly formatted. 
2. There is no spaces between the characters
3. Only following operators are allowed: ‘+’, ‘-‘, ‘*’,’/’


## Next Greater Element
Given an array, for each element in the array, print the first element with an index greater than the given element that is larger than it.  If there is none before the end of the array, the answer is -1.


Example: [4,5,2,25]
Answer:
4 -> 5
5 -> 25
2 -> 25
25 -> -1



## Stock Span Problem

The span of a price is the number of days previous to the current day over which the stocks price has risen. I.e. If the current day is a "bullish" day for the stock, how long as the bullish run been going on. Given stock information for N days, we may want to calculate the span of EACH day. Below is an illustration

![stock span](http://d2o58evtke57tz.cloudfront.net/wp-content/uploads/StockSpanProblem.png)


## Implement a stack using queues
Given a Queue data structure, implement an interface that supports First in Last Out semantics.



# Flatten a linked list of linked lists

You are given a linked list that contains a set of nodes with two pointers, a 'right' pointer and a 'down' pointer, such that every node in the top list has two outgoing pointers, but the nodes following the 'down' pointer only contain a single pointer. The data structure is sorted so that for a given node, it is always less than all of the nodes that can be visited by following it's pointers.

Below is an example:


    5->10->15->20 
    |  |   |   |  
    6  11  17  21 
    |   |  |      
    7  13  19     
    |             
    8             

How do you flatten such a structure to a simple, one dimensional, sorted linked list?
