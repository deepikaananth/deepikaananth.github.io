---
title: The Kalman Filter
---

<div class="toc-content">
#### <u>Table of Contents</u>
1. [What is the Kalman filter?](#what-is-the-kalman-filter)
2. [How does it work?](#how-does-it-work)
3. [An example](#an-example)
4. [Can it be better?](#can-it-be-better?)
<br>[References](#references)
</div>



<div class="post-body">

<span id="wien">
<center>
![**Fig 1.** The denoising effect of the Wiener filter](../../Images/leaves.png){width=100%}
</center></span>

## What is the Kalman filter?

The Kalman filter is a means of state estimation named after the one of the many developers of the concept - <a href="#kalman">**Rudolf Kalman**</a>. It is described as a means of using mutliple noisy measurements of a 
<span id="kalman">
   <small class="sidenote">
   <u>**Rudolf E. Kalman**</u><br>
   Kalman was a Hungarian born American engineer and mathematician known for the filter named after him and the very foundations of its application - the state space representation theory.
   </small>
</span> quantity, usually a "state" measurement to make a best guess estimate of the probable state value at a future time. 


A state measurement can be interpreted quite literally as the state of a system, which for a human being from a physiological perspective be things like their temperature, their heart rate, the insulin levels in their blood stream, and even how they might be feeling emotionally - happy, content, sad, bored, etc. And while temperature and insulin levels are <a href="#cont">**continuous values**</a>, heart rate <span id="cont">
  <small class="sidenote">
  <u>**Continuous variables**</u><br>
   can assume any two infintesimally different values which might for example be similar up to the $10^{-100 th}$ place, and can in general assume any of the uncountable number of values within its range.
  </small>
</span>(and emotional status to some extent) is a <a href="#disc">**discrete state variable**</a>, it <span id="disc">
  <small class="sidenote">
  <u>**Discrete variables**</u><br>
  can assume only a fixed set of values and cannot take intermediate values in between two consecutive discrete ones.
  </small>
</span>can only assumea quantized set of values -integers in this case, and there can be no intermediate fractional values.

Now, discrete or continuous, these "state" values or variables have something in common. They are all values of which we can measure across time and put down in a sequential form as a graph or a trend. And many times engineers and scientists have to deal with systems which are either very complex like the physiology of the animal body, or are such that measurements of some important states can't be easily obtained, like tracking the position and velocity of a spacecraft in real time to make course corrections to follow a planned trajectory.



## How does it work?


The Wiener filter was the predecessor of the kalman filter, named after scientist Norbert Wiener, which is a technique of estimating the state of a system or a variable which has a linear response and is <a href="#lti">**stationary**</a>. <span id="lti">
  <small class="sidenote">
  <u>**LTI systems**</u><br>
  Time invariant systems are those systems whose "dynamics" do not vary over time. They are such that the update rules that take the system from one time step to the next are governed by a fixed set of equations, and given the state of the system at a certain time step, we can repeatedly apply these update rules to get the state of the system at any future or past time.<br>
  **LTI** - stands for linear time invariant systems, and they have output responses which are some linear combination of time delayed input signals.
  </small>
</span>
The Wiener filter is a means of true state estimation upon corruption with noise under the conditions that the noise is additive and we know the statistical properties of the noise, such as its mean and its variance.

<a href="#wien">**Fig 1.**</a> shows the effects of a simple denoising wiener filter applied to a noisy picture and its output when applied as an average over 7x7 pixel groups. When the pixel grouping and the statistical parameters of the noise are estimated optimally, the filter performs quite well, but the results are not optimal. For example, the denoised filter in the <a href="#wien">**Fig 1.**</a> example had as <a href="#mse">**MSE**</a> of 4422.45 compared <span id="mse">
  <small class="sidenote">
  <u>**Mean Squared Error**</u><br>
  Mean squared error is a metric of divergence from a reference quantity calculated as the mean of the element wise squares of difference in component values.<br><br>
  _mse_ = $\frac{1}{n} \sum_{n} ( x_{reference} - x_{being measured} )^2$
  </small>
</span> to the original figure compared to the noisy image with an MSE of 4490.06. And while this is an improvement, it is a slight one and was not satisfactory for applications that the kalman filter was historically first used for, such as the circumlunar trajectory guidance and navigation for the Apollo mission's onboard computers [^1].


The Kalman filter on the other hand, does not need to know the statistical properties of the noise or any adversarial effects distorting the signal to be estimated. It starts with a guess of the mean and the variance of the "noise" and updates its estimates along with its estimate of the state as more noisy observations are obtained.

The pseudo-code for the kalman filter is given below:







## An example









## Can it be better?








### References

[^1]: <a href="https://ntrs.nasa.gov/api/citations/19860003843/downloads/19860003843.pdf">Discovery of the Kalman Filter as a Practical Tool for Aerospace and Industry</a>
