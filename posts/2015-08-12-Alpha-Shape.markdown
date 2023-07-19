---
title: The Alpha Shape
---

<div class="grid">

<div class="toc-content">
### Table of Contents
1. [What is the alpha shape and why do I need it](#what-is-the-alpha-shape-and-why-do-i-need-it?)
2. [The Alpha complex](#the-alpha-complex)
	a) [Simplex](#simplex)
	b) [Simplical Complex](#simplical-complex)
	c) [Simplical k-complex](#simplical-k-complex)
	d) [The Delaunay Triangulation](#the-delaunay-triangulation)
	e) [The alpha complex](#the-alpha-complex)
3. [Properties of the alpha complex](#properties-of-the-alpha-complex)
4. [How do I make my own](#how-do-i-make-my-own)
	a) [Approach 1](#approach-1)
	b) [Approach 2](#approach-2)
5. [Existing Techniques](#existing-techniques)
6. [What next?](#what-next?)
<br>[Footnotes](#footnotes)
</div>


<div class="post-body">

## What is the alpha shape and why do I need it?

A close cousin of the <a class="footnoteRef" href="https://en.wikipedia.org/wiki/Convex_hull">_**convex hull**_</a> [^1] (my post on which you can find [**here**](2015-08-12-2D-Convex-Hull.html)), the alpha shape is a conditionally better fitting polygonal figure enveloping a set of datapoints. Depending on the parameter  $\alpha$,  the alpha shape of a given set of points could range from being a set of disjoint islands connecting only few points each, a highly _**concave**_ [^2] polygon, to even the convex hull itself!

Figures 1, 2 and 3 show three different alpha shapes for the same set of planar points for readers to better understand its nature. ^[Inline notes are easier to write, since you don't have to pick an identifier and move down to type the
note.]

// Insert figures //

Some sources differ on how $\alpha$ is used in the construction of the alpha shape, and it will be worth taking a few minutes to understand why since it directly relates to its algorithmic construction. And for this, we will have to be armed with knowledge of the more general alpha complex which we will cover in the next section.

As to why I began looking into the alpha shape and how to construct it with a homebrewed algorithm, I refer you to my post where I talk about my ongoing research project -[**Safe Online Learning**](2015-08-12-Safe-Online-Data-Driven-Learning.html), part of which involves setting up for an _**autonomous robot agent**_ [^3] a 2D environment with differently shaped obstacles which it will scan using a simulated liDAR. And for the obstacles to be discerned correctly necessitated an algorithm that can compute the boundary of any non-convex shape. The problem is guaranteed to produce the desired obstacle shape to a great degree of accuracy especially since the bottlenecks such as a good estimate of $\alpha$ are easily overcome due to the uniformly gridded 2D environment in our setup.


## The Alpha complex

This section will take the reader on a guided mathematical tour of geometric simplical complexes and will comprise of several sub-sections with illustrative examples, wrapping up with the alpha complex and its mathematical properties.


#### Simplex

A simplex is the geometrical common noun used to refer to shapes constructed by connecting the least number of vertices in arbitrary dimensions so as to form a _**polytope**_ [^4].

// sidenotes on usage of geometric vs. geometrical //
// sidenotes on definition of "polytope" //

To make it more clear, the point is a simplex in the 0-th dimension, a line is a simplex in 1 dimensional space, a triangle the simplex in 2 dimensions, a tetrahedron in 3 D space and so on.


#### Simplical Complex

With an idea of the simplex, it becomes easy to understand a simplical complex (or geometric simplical complex) as a set composed of point vertices, line segments that connect these vertices, triangles, tetrahedra and correspondingly higher n-dimensional simplices. A simplical complex, what I will refer to as a complex from now on is a set made up of different n-dimensional simplices.

// sidenote on the usage of simplices vs. simplexes //


#### Simplical k-complex

Quite simply defined as a simplical complex where the simplex of the largest dimension is a k-dimensional simplex. For example, a 3-complex can have as constituent elements - points, line segments, triangles and terahedra but no simplices of dimensions 4 and above like the 4-simplex pentachoron or the 5-simplex hexateron! 

The _**k-simplex is also the convex hull of k+1 number of points**_ [^5], which is easily verified when we think of the line, triangle and _**tetrahedron**_ [^6]. // ref: https://www.mrzv.org //


#### The Delaunay Triangulation

The delaunay triangulation is a very interesting k-simplical _**tesselation**_ [^7] most commonly seen in 2 dimensions as a triangulation of a collection of planar points such that every triangle formed is circumscribed by an empty circle. They also have the property of maximizing the minimum of each of the triangles' angles. For euclidean distance used as the metric to compute the delaunay triangulation, the tesselation so formed is unique. 

// sidenotes on exceptions to the uniqueness of delaunay triangulations //


#### The alpha complex

The alpha complex as its name suggests is a simplical complex (in 2-D space) formed by points,the line segments connecting the points, triangles formed by three cyclically connected line segments, conditionally dependent on the intersection of 1/$\alpha$ radius circles around each of the data points.

The following is a simple set of steps to construct the alpha complex of a few planar datapoints:

1. Calculate the value of $1/\alpha$
2. Draw circles of radius $1/\alpha$ around each of the data points
3. Connect every pair of points whose circles either touch (kissing circles) or overlap (at two points) 
4. For every triangle so formed by the connecting line segments, check to make sure they are "delaunay" - i.e that they are empty of other data points and if they are not, remove the last drawn connecting line segment
5. Continue the process until all possible points have been connected and all triangles formed are Delaunay!

Figure X. shows the alpha shape constructed for the  value of $\alpha=$ along with the underlying circles of radius $1/\alpha$ and how they overlap.

To wrap it all up, the alpha shape is the alpha complex for a certain $\alpha$ value. And is thus the delaunay triangulation as $1/\alpha \rightarrow \infty$.


## Properties of the alpha complex

The alpha complex has the following properties for a set of points P and some real valued $\alpha$:

1. The distance between any two points $p_1$ and $p_2$ in the alpha complex is at most $2/\alpha$
2. The circumscribing circles of every set of three points connecting to form a triangle is empty of datapoints in P
3. Every three set of points that form a triangle are such that the smallest of their interior angles is always maximized
4. Certain values of $\alpha$ could lead to multiple disjointed sets of smaller complexes
5. The voronoi tesselation or voronoi diagram is the geometric dual of the delaunay triangulation so formed by the alpha complex when $1/\alpha \rightarrow \infty$
6. For a set of uniformly gridded points, each distance $d$ away from its closest neighbors, choosing $1/\alpha$ to be lesser than $d$ will lead to the alpha shape being the discrete point set itself. 


## How do I make my own

The algorithm for the construction of the alpha shape is more nuanced than that of the convex hull. The uncertaintly in the convexity of the resulting shape and the (in)sufficiency of the value of $\alpha$ make the process make for many more edge cases and as a result, more verbose and less efficient code.

The following subsections detail my two approaches, their advantages and their shortcomings and will continue to expand as I work on creating an efficient home made solution for any random set of 2 D points.


#### Approach 1






#### Approach 2






## Existing Techniques






## What next?




<div class="post-footnotes">

#### Footnotes

[^1]:[Convex Hull - Wikipedia](https://en.wikipedia.org/wiki/Convex_hull)
[^2]:[Concave - The opposite of a convex surface, and in context of a polygon a shape with at least one interior reflexive/obtuse angle](https://mathworld.wolfram.com/ConcavePolygon.html)
[^3]:[Autonomous robot - a robot which operates without human supervision](https://en.wikipedia.org/wiki/Autonomous_robot)
[^4]:[Polytope - An n-dimensional analogue of a polygon](https://mathworld.wolfram.com/Polytope.html)
[^5]:[A practical guide to persistent homology](https://www.mrzv.org/software/dionysus/_downloads/560102bd0b0a77e5b34cfa4d65781ce7/dionysus-slides.pdf)
[^6]:[Tetrahedron - the 3-simplex](https://plus.maths.org/content/maths-minute-simplices-atoms-topology)
[^7]:[Tessellation - a tiling pattern made up of repeated interlocking of one or more shapes](https://www.mathsisfun.com/definitions/tessellation.html) 

</div>

</div>
