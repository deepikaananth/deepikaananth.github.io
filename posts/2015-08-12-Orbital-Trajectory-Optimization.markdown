---
title: The Dynamic Travelling Salesman
---

<div class="toc-content">
#### <u> Table of Contents</u>
1. [Introduction and Motivation](#introduction-and-motivation)
2. [Elliptical orbits - problem set up](#elliptical-orbits-problem-set-up)
3. [Ant Colony optimization](#ant-colony-optimization)
4. [Results](#results)
5. [Future scope](#future-scope)
<br>[References](#references)
</div>





<div class="post-body">

## Introduction and Motivation

As a part of a project in the Fall of 2022, a small team and I considered spacecraft tracjectory optimization and began testing out the waters without too much research by setting up the problem in an empty Jupyter notebook. Based on the uninformed opinions from all three team members, the problem materialized into a setup of a hypothetical orbital system with some $n$ number of space debris pieces in highly absurd elliptical orbits that we would have a spacecraft "intercept" to collect[^1] . Such a space trash collector[^2] might not be able to collect too many junk pieces because of physical constraints or power (fuel) constraints in real life just yet, and ours was a highly fantastical set up, but the problem was too irresistible to turn down because it presented us with the opportunity to attempt to code up a (time-varying) travelling salesman problem!



The travelling salesman is a notoriously famous combinatorial optimization problem where the objective is for a salesman to find the shortest <a href="#hamilton">**Hamiltonian cycle**</a> through 
<span id="hamilton">
  <small class="sidenote">
  <u>**Hamiltonian Cycle**</u><br>
  Named after 19$^{th}$ century mathematical Sir William Rowan Hamilton, most famously known for his invention of the concept of *quaternions*[^3], a Hamiltonian cycle is a "tour" of a graph beginning and ending at the same vertex.
  </small>
</span>
 some $n$ cities. The complexity of the question becomes more apparent upon closer inspection to those to whom it might be new:

1. Starting from the first city, there are n-1 cities to pick from, from the second only n-2 and so on...
2. Simply picking the closest city every time will not always (almost never in fact!) lead to a summed shortest travelled distance.
3. The constraint that says the salesman has to travel back to the first city to complete a required round-trip makes the <a href="#mst">**minimum spanning tree**</a> based 
<span id="mst">
  <small class="sidenote">
  <u>**Minimum spanning tree**</u><br>
  The MST is the shortest possible "tree" creating routes in a weighted graph such that the path from any one node to another will always be the shortest possible path!
  ![MST](../../Images/MST.png){width=100%}
  The minimum spanning tree of a weighted, undirected graph, *courtesy: Wikipedia*.
  </small>
</span>
approach intractable.
4. 

Now imagine a similar problem with space debris collection, where the pieces of debris are all continuously moving. This is the time-varying travelling salesman.






## Elliptical orbits - problem set up

The first step was to create the environment by simulating elliptical orbits for the $n$ pieces of debris our spacecraft trash collector has to collect. This was done by using the parametric equation of the 2-ellipse in 3-dimensional space:

$$x(t) = u_x \hspace{0.2cm} cos(t) + v_x \hspace{0.2cm} sin(t) + c_x$$
$$y(t) = u_y \hspace{0.2cm} cos(t) + v_y \hspace{0.2cm} sin(t) + c_y$$
$$z(t) = u_z \hspace{0.2cm} cos(t) + v_z \hspace{0.2cm} sin(t) + c_z$$

The way I understood the intuition behind this parametrization was by considering the projections of an ellipse so generated onto the three orthogonal planes like shown in <a href="#proj">**Fig 1.**</a> The ellipse
<span id="proj">
  <small class="sidenote">
  <u>**An ellipse in 3D space and its projections**</u><br>
  ![Ellipse_projection](../../Images/proj2.png){width=100%}
  **Fig 1.** A 2-ellipse in 3D space and its projections onto the XY, YZ and XZ planes.
  </small>
</span>
 in the sidenote was generated using the values $u_x = 1$, $u_y = 2$, $u_z = 4$, $v_x = 5$, $v_y = 3$ and $v_z = 0$ with the constants $c_x, c_y, c_z$ all 0. This can be interpreted in two ways:

1. The projections are each a 2-ellipse which have parametric equations with the coefficient constants picked in pairs from the 3 available sets, to produce ellipses of the form:
   $$x(t) =  cos(t) + 5 sin(t)$$
   $$y(t) = 2cos(t) + 3sin(t)$$
   For readers familiar with the standard ellipse equation:
   $$ \frac{x^2}{a^2} + \frac{y^2}{b^2} = 1$$
   a simple substitution into the standard ellipse equation of the following form:
   $$ x = a cos(\theta); \hspace{1cm} y = b sin(\theta) $$
   reveals the trigonometric identity:
   $$ \frac{a^2 cos^2(\theta)}{a^2} + \frac{b^2 sin^2(\theta)}{b^2} = cos^2(\theta) + sin^2(\theta) = 1 $$
   

   
2. The ellipse created in 3D space is that unique 2-ellipse which passes through the two 3D vectors $u = (1, 2, 4)$ and $v=(5, 3, 0)$.
   








## Ant Colony optimization











## Results











## Future scope

The many approximations and simplifications we had to make given the project timeline (and the nature of the problem we were trying to solve) made for a toy model variant of an already watered down version of the problem. Some improvements I hope to introduce to the existing code are listed below:

1. Vary the orbital velocities of the pieces of debris based on the nature of their orbit and a little bit of research online to make the simulation more realistic.
2. 










</div>



<div class="post-footnotes">

#### References

[^1]: ["Brane"- membrane spacecraft space debris collector](#https://www.nasa.gov/feature/brane-craft/)
[^2]: [Astroscale](#https://astroscale.com/astroscales-elsa-d-mission-successfully-completes-complex-rendezvous-operation/)
[^3]: [Quaternions](https://mathworld.wolfram.com/Quaternion.html)

</div>
