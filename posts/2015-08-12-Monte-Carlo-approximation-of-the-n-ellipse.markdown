---
title: Monte Carlo approximation of the n-ellipse
---

<div class="toc-content">
#### <u>Table of Contents</u>
1. [Monte Carlo simulation](#monte-carlo-simulation)
2. [Monte Carlo based approximation](#monte-carlo-based-approximation)
3. [The n-ellispe](#the-nellipse)
4. [Areas of closed curves](#areas-of-closed-curves)
   a. [Initializing variables](#initializing-variables)
   b. [Sampling points in a uniform grid and approximating the area](#sampling-points-in-a-uniform-grid-and-approximating-the-area)
   c. [Computing the n-ellipse shape](#computing-the-n-ellipse-shape)
   d. [Convergence to a circle](#convergence-to-a-circle)
5. [Future scope](#future-scope)
<br>[References](#references)
</div>


<div class="post-body">
## Monte Carlo simulation
<a href="#sUlam">**Stanislaw Ulam**$^*$</a> invented the Monte Carlo 
<span id="sUlam">
  <small class="sidenote">
  <u>**Stanislaw Ulam**</u><br>
  Polish born mathematician whose ideas helped physicist Edward Teller develop the idea of the first thermonuclear weapons during the Manhattan Project [^2]. Ulam also invented the concept of Cellular Automata [^3] and the Monte Carlo technique.
  </small>
 technique during the former's time at Los Alamos [^1]. During a period of convalescence, curiosity in trying and failing to combinatorially calculate the probability of drawing a flush set from a deck of cards, he exhasperatedly resorted to repeating the experiment many times and simply counting up the number of times he managed a successful draw [^5]. Following a collaboration with <a href="#vonNeumann">**John von Neumann**$^*$</a>, he then published 
</span>
<span id="vonNeumann">
  <small class="sidenote">
  <u>**John von Neumann**</u><br>
  Hungarian born polymath known for extraordinary contributions in many, many fields from logic and quantum mechanics to game theory and stochastic computing.[^4]
  </small>
</span>
his work, naming the technique the Monte Carlo method after the famous Monte Carlo casino in Monaco due to the similarities of the technique to the way the roulette wheel works.

The technique has since then been used in areas such as optimization, numerical approximation of areas and bounds, and probability estimations.



## Monte Carlo based approximation

The idea is best illustrated with an example (which quickly revealed itself upon closer inspection to be worthy of <a href="#2015-08-12-Estimating-Numpys-randn">**its own post**</a>).

For those familiar with the Python library Numpy, there exists the function ``random.randn()`` which returns <a href="#prng">**(pseudo) randomly$^*$**</a> sampled 
<span id="prng">
  <small class="sidenote">
  <u>**Pseudo randomness**</u><br>
  The nature of computer generated numbers which appear to be statistically random but will repeat or express a discernible pattern after some large, finite number of elements.
  </small>
</span>
data of whatever shape is specified inside its arguments. The ``randn`` function is also described as choosing its sample points from a standard normal distribution. We can verify this as being the case by trying to sample some N number of scalars using the function and plotting them on a 1-dimensional histogram as shown below where N is gradually increased from 20, to 100, to 1000 to 200000, getting closer and closer to the expected characteristic gaussian bell curve centered at 0.




## The n-ellipse

<span id="tri-ellipse">
  <small class="sidenote">
  <u>**Fig.1: A tri ellipse**</u><br>
  <center>
  ![Ellipses with 3 foci and different distance $d$ values](../../Images/tri-ellipse.png){width=80%}
  </center>
  </small>
</span>


In the 2-dimensional sense, an ellipse is a locus of points at constant distance from 2 fixed points. A circle is a special case of the ellipse where all the points are at a constant distance from 1 fixed point. Extending the same generalization to any $n$ points, we can say that by virtue of the circle being a 1-ellipse and the regular (2 focal point) ellipse the 2-ellipse, the n-ellipse can be described mathematically as:

$$ E_n(x,y) = \Biggl\{ (x,y) | \sum_{i=1}^n \sqrt{ (x-u_i)^2 + (y-v_i)^2 } = d \Biggl\}$$

The equation above is understood as being the sum (the big $\sum$ symbol) of the euclidean distances (the square root and the terms inside) from any point on the n-ellipse boundary $(x,y)$ to each individual focus point $(u_i, v_i)$ equal some constant $d$.






## Areas of closed curves

The area of a (finite) closed region bound by one or more curves can be calculated analytically using <a href="#green">**Green's theorem**$^*$</a> involving a double integral. However, this is possible only if there exists a way to parameterize the equation defining a locus of points on a curve, i.e represent the (multivariate) function in terms of a single variable. And many times this is possible as in this example of an imaginary curve $f(x, y, z)$, where some co-ordinate transfer could result in:

$$g(u) = x; \hspace{1cm} h(u) = y; \hspace{1cm} k(u) = z$$

allowing us to rewrite in parametric form for some arbitrarily picked $f$:

$$f(x, y, z) = x^2 + y + \frac{13}{z} = g^2(u) + h(u) + \frac{13}{k(u)}$$

This has turned the curve into a parametric form in just a single variable $u$ which can now be integrated with correct bounds to compute the area.

But, not all curves can be converted into such a parametric form, and so they cannot be integrated in order to analytically compute the area they enclose. And in such cases, numerical alternatives must be considered. For polygons, even non-convex, a <a href="#triangulation">**divide and conquer**$^*$</a> approach usually does it.

So, what about smooth curves like the n-ellipse? Thats' when I had the idea of using the Monte Carlo simulation to approximate the area of the n-ellipse. The steps I took are explained in order below along with snippets of code.



#### Initializing variables

The number of points (the bigger the better as we saw in the toy example), the foci, the constant distance $d$ and empty lists for points inside and outside the n-ellipse to be calculated are defined.

```{#myCode1 .python}
def __init__(self, N, foci, distance):
    self.N = N
    self.foci = foci
    self.d = float(distance)
    self.dist_matrix = scipy.spatial.distance.pdist(self.foci)
    self.inside = []
    self.outside = []
```


#### Sampling points in a uniform grid and approximating the area

The most important function performs the task of sampling points from a uniform grid of a fixed density and then computing which points are such that the sum of their distances from the n foci is lesser than or equal to $d$, appending them to a separate list than the points at distance greater than $d$. When all the points have so been sorted, we then calculate the ratio of the number of points inside to the total number of points and adjust for the scaling with a precalculated factor $f$.


```{#myCode2 .python}
def param_area(self):
    
    # calculate the 'f' factor within bounds of which to sample pts
    f = abs(np.max(foci)) + abs(np.min(foci))
    f = np.max((f, self.d)) * 2.5       
    
    # Sample uniformly gridded points    
    X = np.linspace(-f/2, f/2, int(np.sqrt(self.N)))
    Y = np.linspace(-f/2, f/2, int(np.sqrt(self.N)))
    x, y = np.meshgrid(X, Y)
    x = x.reshape(-1);                    
    y = y.reshape(-1)
        
    # Compute points sum of distances to the foci!
    for i in range(self.N):
            pt = np.array([x[i], y[i]])
            dist = 0                                
            for j in range(self.foci.shape[0]):
                dist += math.dist(pt, self.foci[j,:])
            
            # separate the points as being inside/outside the ellipse 
            if dist <= self.d:
                self.inside.append(pt)
            else:
                self.outside.append(pt)
         
        self.inside = np.asarray(self.inside)
        self.outside = np.asarray(self.outside)
         
        # Computing the approximation of the area of the n-ellipse:
        self.area = (f**2) * len(self.inside) / self.N 
        return self.area
```

The most important points in the snippet just above are summarized as such:

1. The $f$ factor is an attempt to estimate the range of the x and y for the sample points so that there will be points both inside and outside the n-ellipse that the given set of foci and $d$ are going to produce. Sometimes it is difficult to gauge it since we might fall short of the bounds of the n-ellipse itself, or on the other extreme - end up with way too many points outside the ellipse, making the approximation chunky and inaccurate.

2. For readers familiar with the Python ``numpy.meshgrid`` function, the inputs are interleaved to produce every possible combinatorial pair of values. When these outputs are reshaped into 1-dimensional arrays (using ``.reshape(-1)``), we want them to be of size ``N``, since that was the number of points we wanted to sample! And therefore, initially producing ``meshgrid`` inputs of size $\sqrt{N}$ each will give sample point $x$ and $y$ coordinates of desired length $N$. 

3. The area obviously is not just the ratio of the number of points inside the ellipse to ``N``. It needs to be scaled by $f^2$, once for the x axis and once for the y axis, since both axes have points extending from $-f/2$ to $f/2$.






#### Computing the n-ellipse shape

Once we have the set of points that lie inside or on the boundary of the ellipse, running my home-made gift-wrapping convex hull algorithm produced convincing results for a dense enough sample grid. The code and explanation for the convex hull can be found in my <a href="#2015-08-12-2D-Convex-Hull-algorithm">**post**</a> on the same. 

Outputs from a few interesting runs are shown in the images below.


Given the **4 foci** at the points $(1,8), (4, -3), (-13, -6)$ and $(20,-2)$ with sum of distances chosen to be $d=57$, the following was obtained as shown in <a href="#4ellipse">**Fig.2**</a> and <a href="#4ellipseHull">**Fig.3**</a>.


<span id="4ellipseHull">
  <small class="sidenote">
  <u>**Fig 3.**</u> Piece-wise linear 4 ellipse boundary approximated by the convex hull algorithm<br>
  ![](../../Images/4_ellipse_57_hull.png){width=100%}
  </small>
</span>
<span id="4ellipse">
<center>
![**Fig 2.** 4 ellipse with $d$ = 57](../../Images/4_ellipse_57.png){width=70%}
</center>
</span>


A set of 5 foci with a much bigger $d$ value 300 produced the following results as seen in Figures <a href="#5ellipse">**4**</a> and <a href="#5ellipseHull">**5**</a>. It was calculated to have an ***area*** of 123715.15455322266 sq. units.


<span id="#5ellipseHull">
  <small class="sidenote">
  <u>**Fig 5.**</u> Piece-wise linear 5 ellipse boundary approximated by the convex hull algorithm<br>
  ![](../../Images/5_ellipse_Hull.png){width=80%}
  </small>
</span>
<span id="5ellipse">
<center>
![**Fig 4.** 5 ellipse with $d$ = 300](../../Images/5_ellipse.png){width=70%}
</center>
</span>


#### Convergence to a circle

Three pairs of images of an 8 focus ellipse with $d$ values 334, 650 and 3400 are shown for comparison in the Figures <a href="#8small">**6**</a>, <a href="#8med">**7**</a> and <a href="#8big">**8**</a> along with their approximated areas. And the most interesting takeaway is that the bigger the $d$ value gets, the closer to a circle the generated n-ellipse looks, perhaps implying an eventual convergence, which is a reasonable conclusion! This is because the bigger the $d$ value, the more infinitesimally closer the foci come to becoming one central point and the infinitely far away from the boundary of that n-ellipse which will have become a circle.


<span id="8small">
<center>
![**Fig 6.** 8 ellipse with  $d$ = 334  with  ***area*** = 643.6118836249999  sq. units](../../Images/8ellipseSMALL.png){width=120%}
</center>
</span>
<span id="8med">
<center>
![**Fig 7.** 8 ellipse with  $d$ = 650  with  ***area*** = 16822.928408203123  sq. units](../../Images/8ellipseMED.png){width=120%}
</center>
</span>
<span id="8big">
<center>
![**Fig 8.** 8 ellipse with  $d$ = 3400  with  ***area*** = 562697.6306249999  sq. units](../../Images/8ellipseBIG.png){width=115%}
</center>
</span>



## Future scope

I considered the results I got to be be quite successful and the n-ellipse allowed me to explore perhaps one of the most interesting applications for area estimation of a closed curve using the Monte Carlo technique that I had come across. However, this isn't the end of it; a few ideas I have for follow up work on the same are listed below (that someday I hope to make more posts about!):

1. Replacing the convex hull algorithm with a <a href="#bezier">**spline based**</a> boundary estimation 
<span id="bezier">
  <small class="sidenote">
  <u>**Bezier curves**</u><br>
  A continuous curve constructed passing through a given number of points with boundary conditions and smoothness constraints.
  </small>
</span>

2. Systematically better the calculation of the scaling factor $f$.

3. Update the images on this post to have a better color scheme.




</div>


<div class="post-footnotes">

#### References

[^1]: [METROPOLIS N, ULAM S. The Monte Carlo method. J Am Stat Assoc. 1949 Sep;44(247):335-41. doi: 10.1080/01621459.1949.10483310. PMID: 18139350.](#https://web.williams.edu/Mathematics/sjmiller/public_html/105Sp10/handouts/MetropolisUlam_TheMonteCarloMethod.pdf)
[^2]: [The Manhattan Project](#https://www.osti.gov/opennet/manhattan-project-history/Events/events.htm)
[^3]: [Cellular Automata](#https://mathworld.wolfram.com/CellularAutomaton.html)
[^4]: [John von Neumann](#https://www.ias.edu/von-neumann)
[^5]: [Stan Ulam, John von Neumann and the Monte Carlo Method](#http://www-star.st-and.ac.uk/~kw25/teaching/mcrt/MC_history_3.pdf)




</div>
