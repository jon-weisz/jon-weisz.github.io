---
title: "Linked Lists Lecture 2"
layout: teaching_page
author: jon_weisz_columbia
---

<iframe width="854" height="510" src="https://www.youtube.com/embed/koPSfN06gqo#t=43
" frameborder="0" allowfullscreen></iframe>

## Outline
 * Errata
 * Problem 2.27
 * Homework 1 submission guidelines
 * Java Collections
 * Gradle 101
 * Factorial, Precision, and Linked Lists

##Errata
  * Tower of Hanoi Big O - Not an arithmetic series
    * T(N) = 2*T(N -1) + 1
    * T(1) = 1
    * T(2) = 3
    * T(3) = 7
    * T(4) = 15

    * What is the pattern?  
      * 2^N - 1  
    * Inductive Proof  
      * T(N) = 2*(2^(N-1) - 1) + 1  
      *      = N^2 - 2 + 1  
      *      = N^2 -1  

  
<br>
<br>

## Problem 2.27

   * This problem is really hard.
   * Don't spend forever on it. 
   * Hints
     * What do you learn about after each test?
     * sqrt(N) time on a 2 dimensional problem implies some kind of "walking"
     * Try drawing a graphical representation of what each test accomplishes
     * Find a way to most effectively apply the test
       * O(N) on N^2 items implies each test eliminates O(N) options.
  
<br>
<br>

# Homework 1 Submission Guidelines  

## Written Section  

  * Written homework must be submitted in class as a printout at the beginning of class. 
  * If you cannot attend class, written homework must be submitted digitally before class begins. If submitting digitally without a hard copy, be sure to email Bailey and let her know that you have done that. I would strongly prefer that if you submit a digital copy, you type it up. 
  * In homework, as in life, neatness counts. I'm going to instruct the TAs NOT to struggle to read your homeworks. 
 

## Programming Section
  * For this assignment, submit the homework by using the dropbox on Courseworks. Your homework should be in a .tar or zip file named "uni_homework_1"
  * Part 1 should be in the part_1 directory
  * Part 2 should be in the part_2 directory
  * Each directory should have a build.sh that runs the javac command to compile your program
  * The output of the build script for part 1 should be MakeChange or MakeChange.class, such that the grader can run $java MakeChange some integer to test part 1.
  * Similarly, the output of the build script for part 2 should be PermutationTest or PermutationTest.class such that the grader can run java PermutationTest to test part 2. 
  * Part 2 also requires a run script, since including the graph package requires a adding the .jar file the class path
  * See [here for a sample build script](http://www.cs.columbia.edu/~jweisz/W3137/homework_files/homework1_scripts/build.sh) and here for a [sample run script](http://www.cs.columbia.edu/~jweisz/W3137/homework_files/homework1_scripts/run.sh)
<br>

# Java Collections
  * There are many algorithms that require collections of objects.
  * Collections share some common features.
  * We can organize these common features into hierarchies
  ![Java Collections hierarchy](http://www.javatpoint.com/images/collectionhierarchy.JPG)

    * [Iterables](http://docs.oracle.com/javase/7/docs/api/java/lang/Iterable.html) support foreach (i.e. iterating over each element).
    * [Collections](http://docs.oracle.com/javase/7/docs/api/java/util/Collections.html) support add, remove, size, clear, contains and a few more things
    * [Set](http://docs.oracle.com/javase/7/docs/api/java/util/Set.html) supports a guarantee of *uniqueness*
      * add is a noop is the set contains an object of equal value
      * can be optimized for contains, intersection, and union of collections.

    * [Queue](http://docs.oracle.com/javase/7/docs/api/java/util/Queue.html) support for frequent addition and removal of individual items. 
      * Additional methods: element() - Gets the head object, usually the most recently added, offer() - Attempt to add an element if it will be fast, peek() - Gets the head object, returns null if no objects, poll() - Retrieve and remove head. Return null if empty, remove() - Removes head, returns nothing. 
      * Frequently used as holding place for work
      * Usually Fifo (first in first out)
      * Interface is very expressive. Designed to allow heavy optimization. 
            
    * [List](http://docs.oracle.com/javase/7/docs/api/java/util/List.html) supports indexing by order
      * get(index)
      * indexOf(value)
      * set(index, value)
      * subList(start, end) 
    
    * [Map](http://docs.oracle.com/javase/7/docs/api/java/util/Map.html) supports indexing by an arbitrary object.	
      * i.e. map.get(recordname)
      * Creates a functional relationship between Keys and Values
      * Keys must be a set, values have no (few) restrictions. 
    

  * These categories describe the *interfaces* not the *implementations*
    * Specialization determines implementation specific advantages
      * Array list vs linked list. 
    * Further specialization may add further interfaces.
   

  * Why do we care?
    * Designing algorithms to most generic level allows reuse of code
    * Designing algorithms to more specific level allows use of assumptions about implementation specific advantages. 

    * This is ALWAYS a tradeoff. 

# Gradle 101
  * What is Gradle? 
    * A scripting environment
      * Written in Groovy (An interpreted language that supports Java like syntax)
        * Groovy supports some much more concise language too.
    * A set of tools and conventions for making build scripts.
  

    apply plugin: 'java'    

     // Create the factorial project as a compileJava task  
    task factorial(type: JavaCompile) {  
    source {  
        files('src/factorial.java')  
    }  
    destinationDir = file("bin/")  
    classpath = files("classes/")  
    }  

  * The [JavaCompile](https://gradle.org/docs/current/dsl/org.gradle.api.tasks.compile.JavaCompile.html) task type defines most of what you'll need.
  * Conventions are very important. Learn to work with them.

# Using Linked Lists for Fun and Profit

  * What is the biggest number an [integer](http://docs.oracle.com/javase/7/docs/api/java/lang/Integer.html) can represent?  

  * What is the largest [double](http://docs.oracle.com/javase/7/docs/api/java/lang/Double.html)?

  * How fast does [factorial](http://en.wikipedia.org/wiki/Factorial) grow?
  
  * How do we calculate the factorial of large numbers?
  
    
      
    