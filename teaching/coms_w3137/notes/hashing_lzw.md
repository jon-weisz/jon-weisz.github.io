---
title: "Test"
layout: teaching_presentation
author: jon_weisz_columbia
---


<section data-markdown data-separator="^\n---\n$" data-vertical="^\n--\n$" data-notes="^Note:">
<script type="text/template">

# LZW Compression and Hashing
---

---

## Overview
---
* Midterm review
* Review of Huffman Encoding
* LZW Encoding
* Hashing
* Homework 4 

---

## Huffman Encoding
* Recall that given a set of characters to compress, we said that we could create the optimal variable length code using a binary decision tree
  * Create a forest of trees
  * Each tree gets a single node with its frequency as its weight
  * Merge lowest weight trees by adding them as subtrees of a new node
  * Recalculate weight as sum of two subtrees
  * Continue until one tree remains. 
* Recall that this algorithm is greedy, and that it is only optimal for a known set of data.

--

<iframe width="1280" height="750" src="http://algoviz.org/OpenDSA/AV/Binary/huffmanBuildAV.html" frameborder="0" allowfullscreen></iframe>


--

## Pitfalls of Huffman Encoding
* Have to predetermine the size of the data to compress.
 * You could chose whole words instead of characters, but you need to make an explicit choice. 
* Have to transmit the encoding table itself. 


---

## LZW Compression
* Similar to an online, data driven Huffman encoding
  * Replace each element or repeated sequence with a code.
  * Codes are fixed length > element length
  * There are a fixed number of codes.
  * Each code has more bits than the elements do. 
  * A code may represent multiple elements in a sequence.

--

## LZW Comression (Continued)
* The encoding is generated as the data is processed
  * Populate a table with codes for each element
  * Every time a new sequence is seen that is not in the list of codes
    * A new code is generated to represent that sequence.
    * Output the sequence up to the current character which makes the sequence novel.
    * Empty the sequence up to the current character.

--


## Compression Example 1

* Compress banana_bandana
* Starting table  0:a, 1:b, 2:d, 3:n

![Test]({{site.url}}/teaching/coms_w3137/images/lzw_compression.png)  

--


## Compression Example 2

![Test]({{site.url}}/teaching/coms_w3137/images/lzw.png)  

--

## Decompression

![Test2]({{site.url}}/teaching/coms_w3137/images/decompression_algo.png)


--

## Decompression Example 

![Test2]({{site.url}}/teaching/coms_w3137/images/lzw_decompress.png)

---

## LZW Advantages
* No preset codebook
  * Adapts to the data
* Can compress longer sequences
* No need to transmit code book
  * Only the alphabet of elements must be.
  * The rest is can be recreated from the data stream
* Appropriate for streaming data
* Loseless

--

## LZW Disadvantages
* Less compact than am optimal precomputed codebook could be. 
  * Example ABCDEFGHIABCDEFGHI could be compressed to 1: ABCDEFGHI 11
  * LZW will compress it to ABCDEFGHI13579
* Bit manipulations may not be 8 bit aligned
  * Awkward to code, less efficient to work with. 
* Table might fill up.

--

## LZW Extensions
* Frames
  * Dynamically recompute clear when compression ratio drops too low.
* Make Lossy
  * Reduce the size of the alphabet to improve compression

---

## How do we look up the right row in the table for each sequence?
* Linear search is slow. {% fragment %}
* A Binary Search tree might be faster {% fragment %} 
  * Sequence may have arbitrary length 
  * Comparison itself is slow 
* Is there an O(1) soluton? {% fragment %}
  * If we could map from a sequence of characters to an integer, we could use an array 
    * This is called Hashing {% fragment %}

---

# Hashing
  * Hash Tables {% fragment %}
  * Associative Arrays {% fragment %}
  * Dictionaries {% fragment %} 

--

## Dictionaries are awesome
* Dictionaries are common and easy to use in modern programming languages
  * In many cases, most objects can be hashed automatically. {% fragment %}
    * O(1) lookup makes many applications almost magically useful
    

<div class="fragment">
<pre><code>
 def memoized_function(data):
     if self.dict.has_key(data):
     	return self.dict[data]
     else:
        answer = ... do something expensive
        self.dict[data] = answer
        return answer

</code>
</pre>
</div>

--

## Hashing Example {SSN: Student}
* Each student at Columbia has a unique Social Security Number
  * This makes them a good identifier, but they are 9 digit numbers {% fragment %}
  * There are only ~ 20,000 students {% fragment %}
  * If we were to allocate an array of 10^9 students, it would be mostly empty (sparse) {% fragment %}
* A hash of the Social Security Number may be more practical {% fragment %}
  * H(SSN) = SSN % 20000 would reduce the size of the array to the same as the minimal number of students
  * But there is no guarantee that no two hashed SSNs would be the same!
    * This overlap is called a "hash collision"

--

## Hashing Example Strings of length < 10

* There are 26^10 + 26^9 + 26^8 + ...26 possible strings.
  * This is a huge number
* We want to use a reduced range, since we will not store this many strings ever. 
* To distinguish between different strings, a character by character hash is reasonable
* This strategy can be extended to any object
  * Read object one byte at a time. 

--

## Problems in hashing
* Hash functions must be fast {% fragment %}
  * Otherwise there is no point 
* Some applications require arbitrary sized data. {% fragment %}
* We may not know apriori how much data we must store. {% fragment %}
  * Table size can grow with data if the hash function can adapt. 
  * If the table size is too small, we will have more collisions.
* We may not know how the data is distributed {% fragment %}
  * We need a generic hash function with a low  probability of collision.
  * This means we need a function that spreads the data out evenly <br> <br>
* Can anyone think of a magic function that would do this for us? {% fragment %}

--

# There is no magic.
* What do we do? {% fragment %}

---

## Hash table design
* Choose a table size {% fragment %}
  * large enough to spread the data out
  * but not so large that space is wasted <br> <br>
* Choose a hash function {% fragment %}
  * quick to compute 
  * accepts arbitrary number of elements in data
  * produces uncorrelated data from possibly correlated input
    * produce even distribution <br> <br>
* Choose a policy to handle collisions.  {% fragment %}

--

## Pick prime table sizes
* index = Key % table_size
  * If the table size is an even number and the key is even, then
the index will be an even.
  * Since the key is often an address, and addresses are always even, this would only use even indices

--

## Prime table sizes (Continued)
* More generally
 * Lets say our hash produces {x , 2x, 3x, 4x, 5x, 6x...} for some x
 * Number of possible buckets m = table_length/GreatestCommonFactor(table_length, x)
 * To make sure hash codes are spread out
  * Avoid hash codes that are multiples of other hash codes
    * Hard for large tables
  * Make m = table_length by making GreatestCommonFactor(table_length, x) 1
   *  This means table_length must share no factors with x.
   * Most likely with prime table_lengths
  

--

## Picking hash functions
* Uniform randomness
* Likely to be coprime with tablesize
* Can be reapplied for multi-element objects
* Fast

--

## A standard hash functions
Standard string hash: Calculate large polynomial in prime number
<pre><code>
public int hash(String key, int tableSize){
       int hashVal = 0; //uses Horner’s method to evaluate a polynomial
       for( int i = 0; i < key.length( ); i++ )
       	    hashVal = 37 * hashVal + key.charAt( i );
        hashVal %= tableSize;
	if( hashVal < 0 )
	    hashVal += tableSize; //needed if hashVal is negative
	return hashVal;
}
</code>
</pre>

--

Boost library: XOR with psuedorandom bits
<pre><code>
size_t hash_value(size_t seed, T val){	   	
    seed ^= val  + (seed<<6) + (seed>>2);
    return seed;
}

size_t hash_combine(T[] val){
    size_t seed = 0;
    for (int i = 0; i < val.length(); ++i)
        seed = hash_value(val[i])
    eturn seed
}

</code></pre>

--

## Pick collision resolution strategy
* Collisions are inevitable unless we know the data in advance
* Seperate Chaining
  * Store collection at hash index
  * Insert elements into collections
  * Number of elements in collection is expected to be load_factor = Number of elements in table / table size on average
  * If the keys are evenly distributed
    * O(1) to find index
    * O(F(load_factor)) to find object in collection
    * For linked lists O(load_factor)
    * If table size is >> than 1, this has the same Big O as linear search

--

## Collision Resolution strategy (continued)

* Probing
 * Hash value used as starting point for search.
  * Linear - Start at x, check x+1... until end of table
   * Problem - Once a collision occurs in a region, another one becomes more likely. 
   * Deletion may create empty spots 
    * Interrupt search
    * Deletion must be lazy or dictionary must be defragmented.

--

## Collision Resolution strategy (continued)
* Probing  
 * Quadratic 
   * Start at x
   * check at (x + i^2)%table_size, where i is the probe number
   * If table size is prime and load_factor < 2, this must eventually find a space. 
 * Hash based offset index = H(key) + i*G(Key)
  * As long a G(key) is < table_size and G(key) and table_size are relatively prime, this will eventually terminate.  
 * Multiple Hash functions - try f1(key), f2(key), f3(key) ...

--

## Adjusting table size
* Some schemes require a low load factor to succeed
  * i.e. probing scheme fails
* We can make the array a vector that approximately doubles in size  (nearest prime) when it is too full
  * But the hash function is probably using the the % table_size
  * Need to rehash
    * Still ~ O(1) by the same amortized analysis as the vector insertion. 

---

## Homework 4 LZW Encoding and GIFs

* A skeleton for the homework will be up on github    
  * You will need to merge it in using git pull  <br> <br>
* This homework is all programming.  <br> <br>
  * LZW encoding of arbitrary byte streams    
  * Implement associative container with tree and hash table.    
  * Implement color space compression using K-Means and KD trees  <br> <br>

</script>
</section>
