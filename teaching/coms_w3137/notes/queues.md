---
title: "Queues"
layout: teaching_page
author: jon_weisz_columbia
---


## Outline
 * Introduction to Queues
 * Implementations
 

##Introduction to Queues
  * Queues are First in First Out 
  * The following animations are courtesy of Dr. Galles at University of San Francisco[^1] and wikipedia. 
  ![Queues](http://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Data_Queue.svg/300px-Data_Queue.svg.png)
  * [Queue collection object](http://docs.oracle.com/javase/7/docs/api/java/util/Queue.html)
    * Semantics:
	  * queues have a pointer to a front item and an end item.
      * enqueue(E) - Add to the end of the queue
      * deque - Remove the first item in the queue and return it
	  * is_empty - are hthe front and end items null
	  * is_full - is there space left in the queue.

   

##Implementations

* Linked list implementation

<iframe src="http://www.cs.usfca.edu/~galles/visualization/QueueLL.html" width="600" height="600"></iframe>

 <br>
 
  * One advantage of the linked list implementation is that it is never "full".
  * Instead of tracking the head and tail node, we can just track the tail node and make the tail nodes "next" point to the head.
    * This method uses a "circularly" linked list

![Circularly linked list](http://upload.wikimedia.org/wikipedia/commons/d/df/Circularly-linked-list.svg)

* Array implementation

<iframe src="http://www.cs.usfca.edu/~galles/visualization/QueueArray.html" width="600" height="600"></iframe>


  * Advantages - Faster access, lower memory overhead
  * Disadvantages - Fixed size!
  * The queue "walks" within it's underlying array.
  * Notice that the array indices must be treated implicitly as a ring.
    * When queueing, tail = (tail + 1)%(Capacity)
	* When dequeing, head = (head + 1)%(Capacity)
	* This sort of operation is called a "circular array"


  * How do we overcome the size limitation?
    * Creating a new array and copying the data every time an object is added is very inefficient.
	* Every time an object is added size(queue) copies are done.
	* Adding N objects does O(N^2) work - Terrible.
	  <br>
	  <br>
	  <br>
	  <br>
	  <br>
	  <br> 
	* Instead, if we double the array size each time, N objects must be added to force a copy.
	* Doing 2N additions, after the Nth addition no copying is done until the 2Nth addition.
    * O(N) work instead of O(N^2)
	* N objects inserted using 2N work - what is the big o per item?
	<br>
	<br>
	  * Constant time
	<br>
	* This is called amortized analysis. 
	  * Using naive analysis big O analysis, taking the most expensive branch each time, we still arrive at a big O of n^2.
	  * However, we can clearly define how often the worst case scenario occurs, and establish a tighter, lower bound.

      <br>
	  <br>
	  <br>
	  <br>
	  <br>
	  <br> 
	  

  * What about reducing the size of the queue after many deques?
    * Should we shrink when size is capacity/2?
	<br>
	<br>
	<br>
	  * What happens if you keep adding and removing at the boundary?
	    * Consider the following implementation of a stack using a resizable array
		![stack-array]({{site.url}}/images/stack-array.png)
	    * Continuously doing n work to add and remove one object. O(n^2) for n adds and deletes. Again, terrible.
        * This kind of behavior is called thrashing. It arises in many other ways.
        * Instead?
		<br>
		<br>
		<br>
		<br>
		<br>
		  * Shrink at capacity/4!
		<br>
		<br>
    * Special concerns for a queue
	  * The layout of a queue has special semantics.
	    * The end wraps back to the beginning.
		* Easiest implementation is to use create new array.
		* Copy from head to tail using same modulo arithmetic. 
  
  * Applications
    * Queues are often used for "fair" scheduling
	  * Process scheduling
	  * Print job scheduling

    <br>

    * Queues are also used for breadth first search
	  * Start with a potential solution
	  * Generate new candidates from solution
	  * Visit each of these solutions and check if they meet the goal criterion
	  * Repeat for each candidate until goal criterion is found, adding new candidates to the queue
	  * [Maze Solving](mazesearch.txt)
	

[^1]: http://www.cs.usfca.edu/~galles/visualization/

