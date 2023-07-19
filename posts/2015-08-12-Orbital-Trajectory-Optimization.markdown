---
title: The Dynamic Travelling Salesman
---

<div class="toc-content">
#### <u> Table of Contents</u>
1. [Introduction and Motivation](#introduction-and-motivation)
2. [Elliptical orbits - problem set up](#elliptical-orbits-problem-set-up)
3. [Ant Colony optimization](#ant-colony-optimization)
4. [Results](#results)
   [References](#references)
</div>





<div class="post-body">

## Introduction and Motivation

As a part of a project in the Fall of 2022, a small team and I considered trying out some spacecraft tracjectory optimization and began testing out the waters from without too much research by setting up the problem. Accounting from inputs from all three team members soon materialized into a hypothetical system with some $n$ number of space debris pieces in highly absurd elliptical orbits that our spacecraft would have to "intercept" to collect[^1] . Such a space trash collector[^2] might not be able to collect too many junk pieces because of physical constraints or power (fuel) constraints, and ours was a highly fantastical set up, but the problem was irresistible because it presented us with the opportunity to attempt to code up a (time-varying) travelling salesman problem!



The travelling salesman is a combinatorial optimization problem where the objective is for the salesman to find the shortest path between some $n$ cities and go back to where he started. Now imagine a similar problem with space debris collection, where the pieces of debris are all continuously moving. This is the time-varying travelling salesman.














</div>



<div class="post-footnotes">

#### References

[^1]: ["Brane"- membrane spacecraft space debris collector](#https://www.nasa.gov/feature/brane-craft/)
[^2]: [Astroscale](#https://astroscale.com/astroscales-elsa-d-mission-successfully-completes-complex-rendezvous-operation/)

</div>
