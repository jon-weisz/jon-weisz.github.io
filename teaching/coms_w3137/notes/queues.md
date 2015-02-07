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
	* Can we fix the array implementation?
  * Instead of tracking the head and tail node, we can just track the tail node and make the tail nodes "next" point to the head.
    * This method uses a "circularly" linked list

![Circularly linked list](http://upload.wikimedia.org/wikipedia/commons/d/df/Circularly-linked-list.svg)

* Array implementation

<iframe src="http://www.cs.usfca.edu/~galles/visualization/QueueArray.html" width="600" height="600"></iframe>


  * Advantages - Faster access, lower memory overhead
  * Disadvantages - Fixed size.
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
	  * What happens if you keep adding and removing at the boundary
	    * Continuously doing n work to add and remove one object. O(n^2) for n adds and deletes. Again, terrible.
        * This kind of behavior is called thrashing. it arises in other ways.
        * Instead?
		<br>
		<br>
		<br>
		<br>
		<br>
		  * Shrink at capacity/4
		



[^1]: http://www.cs.usfca.edu/~galles/visualization/
[^2]: ["Brown, B., (2001). Postfix Notation Mini-Lecture. Retrieved on 2015/2/4"](http://bbrown.spsu.edu/web_lectures/postfix/)
[^3]: http://insecure.org/stf/smashstack.html
