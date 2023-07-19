---
title: Linear Quadratic Regulator
---

<div class="toc-content">
#### <u> Table of Contents</u>
1. [Linear systems and Quadratic Objectives](#linear-systems-and-quadratic-objectives)
   a. [Linear differential equations](#linear-differential-equations)<br>
   b. [Control inputs](#control-inputs)
   c. [Quadratic objectives](#quadratic-objectives)
2. [Discrete and continuous time](#discrete-and-continuous-time)
3. [The Riccati equation](#the-riccati-equation)
4. [Unconstrained optimal control](#unconstrained-optimal-control)
5. [Coding up a discrete LQR](#coding-up-a-discrete-lqr)
6. [Future scope](#future-scope)
<br>[References](#references)
</div>



<div class="post-body">


## Linear systems and Quadratic Objectives


#### Linear differential equations

Linearity is the property of a function which makes it an additive combination of proportional terms of its arguments (and sometimes also a real value like 43.81 in <a href="#eq1">**eq 1**</a>) of the same dimension. For example, the function $f(x, y, z)$ is linear, since it is a sum of linear terms in each of its input variables $x, y$ and $z$

<span id="eq1">
$$f(x, y, z) = -5x + 278y + 43.81 \hspace{1cm} .....(1)$$
</span>

A linear system is used to describe a differential equation where the function being subject to the derivative operator is linear in its input arguments and this results in some interesting properties. Lets consider for example, this linear system described by the first order linear differential equation in $x$:

<span id="eq2">
$$\frac{df(x)}{dt} = -5 \frac{dx}{dt} + 278 x + 43.81 \hspace{1cm} .....(2)$$
</span>

the beauty of which lies in the fact that this can be solved analytically [^1] to give the solution:

<span id="eq3">
$$x(t) = \hspace{1cm} .....(3)$$
</span>

And this is useful because for any real system whose behavior can be modeled using equation <a href="#eq1">**(1)**</a>, we can determine $x(t)$ or the <a href="#state">**state$^1$**</a> of the system at any 
<span id="state">
  <small class="sidenote">
  <u>**State**</u><br>
  The state of a physical system is a vector of real/complex valued quantities jointly describing its instantaneous quantitative properties; an example could be a 5-dimensional vector comprising of position _(x,y)_, speed, acceleration and orientation to describe a car modeled as a point mass.
  </small>
</span>
time "t" which is  usually what $x$ and $t$ are modeled to be. Just a few things that this powerful tool can help us learn about any real system and its behavior include:

1. being able to know its state (if otherwise undisturbed) at any future time
2. learning its long term behavior and see if it converges to a <a href="#steady">**steady state$^2$**,</a> 
<span id="steady">
  <small class="sidenote">
  <u>**Steady state**</u><br>
  A convergence criterion of any dynamic sytem; control theory uses the term to describe the stable behavior of the differential system describing the state of a system which reaches and stagnates as a fixed value beyond certain time period.
  </small>
</span>
or an unchanging value of $x$ for any large $t$ as $t \rightarrow \infty$
3. being able to classify the system as chaotic if the state values do not converge or repeat in pattern ever!
4. making the system <a href="#control">**controllable$^3$**</a> by applying suitable control inputs to tweak
<span id="control">
  <small class="sidenote">
  <u>**Controllable**</u><br>
   In this context simply means applying to the system some input function **u** that the user controls to influence its behavior. For example:
  $$\frac{df}{dt} = -5 \dot{x} + 278x + 10u$$
  </small>
</span>
its behavior to meet certain goals.



#### Control inputs

Control inputs are the way we (designers and engineers) interact with systems! They are a means of overriding the natural tendencies of a real world system and getting it to do what we want it to. A classic example is Newton's law of inertia: 

<center>
*A body continues to remain at a state of rest or a state of continuous motion unless acted upon by an external force*.
</center>

Which is critical to our understanding of the world and the way we have come to **model** and manipulate real world systems (such as through differential equations and control inputs), a long way from empirical Aristotelian physics

<center>
*A body always falls at a speed proportional to its weight.*
</center>

Once we have found the natural laws that a system is governed by such as gravity, magnetic attraction, friction, viscosity, drag etc and we have ourselves a set of differential equations, we can then apply a control input to manipulate it. Let us consider the same linear differential equation as in <a href="#eq2">**(2)**</a> and give it an additive control input denoted by **u**.

<span id="eq4">
$$\frac{df(x(t))}{dt} = -5 \frac{dx(t)}{dt} + 278 x(t) + 43.81 + u(t) \hspace{1cm} .....(4)$$
</span>




#### Quadratic Objectives








## Discrete and Continuous time







## The Riccati equation







## Unconstrained optimal control







## Coding up a discrete LQR







## Future scope



</div>

<div class="post-footnotes"> 
### References

[^1]: [Analytical solution to the linear ODE](https://tutorial.math.lamar.edu/classes/de/Linear.aspx)


</div>
</div>



