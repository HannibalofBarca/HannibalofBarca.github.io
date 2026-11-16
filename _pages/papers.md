---
layout: page
title: Publications
permalink: /papers/
---

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  
  <img src="{{ site.baseurl }}/images/victr.jpg" alt="VICTR Paper Thumbnail" style="width: 250px; height: 250px; object-fit: cover; object-position: center; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;" />
  
  <h3 style="margin-top: 0;">
    VICTR: Value-Informed In-Context Learning for Vision-Language-Action Models
  </h3>
  <p style="margin-top: -5px; margin-bottom: 15px;">
    <a href="https://ai4ce.github.io/VICTR/" target="_blank" title="Project Page" style="margin-right: 6px; display: inline-flex; transition: opacity 0.2s; text-decoration: none; font-size: 0.8em; background-color: #f3f4f6; padding: 4px 8px; border-radius: 4px; color: #0366d6; border: 1px solid #d1d5da; white-space: nowrap;">🌐 Project Page</a>
    <a href="https://arxiv.org/abs/2611.08698" target="_blank" title="arXiv" style="margin-right: 6px; display: inline-flex; transition: opacity 0.2s; text-decoration: none; font-size: 0.8em; background-color: #f3f4f6; padding: 4px 8px; border-radius: 4px; color: #0366d6; border: 1px solid #d1d5da; white-space: nowrap;">📄 arXiv</a>
    <a href="https://github.com/ai4ce/VICTR" target="_blank" title="Code" style="margin-right: 6px; display: inline-flex; transition: opacity 0.2s; text-decoration: none; font-size: 0.8em; background-color: #f3f4f6; padding: 4px 8px; border-radius: 4px; color: #0366d6; border: 1px solid #d1d5da; white-space: nowrap;">💻 Code</a>
  </p>
  
  <p style="font-style: italic; color: #586069; margin-bottom: 15px;">
    Luca Macesanu<sup>&ast;</sup>, Tianluo Zhang<sup>&ast;</sup>, Aditya Patil, Archit Sharma, Kevin Angers, Christopher M. Clark, Chen Feng, Juexiao Zhang — arXiv preprint, 2026 (<sup>&ast;</sup>co-first authors)
  </p>
  
  <p>VICTR enables in-context learning in vision-language-action models by retrieving demonstration context according to task progress rather than visual similarity. An In-Context Value Function Estimator (IC-VFE) estimates progress against a reference demonstration, and the demonstration chunks at the matching stage are supplied to a π<sub>0.5</sub> policy post-trained for in-context action generation. On unseen out-of-domain real-world manipulation tasks, VICTR raises success from 6.2% to 23.8% over a fine-tuned π<sub>0.5</sub> baseline and nearly doubles task progress (28.9% → 55.5%), with no parameter updates at deployment.</p>
  
</div>

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  
  <img src="{{ site.baseurl }}/images/active_suspension.png" alt="Active Suspension Paper Thumbnail" style="width: 250px; height: 250px; object-fit: cover; object-position: top center; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;" />
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    Neural Network-Based Control for Vehicle Suspension Systems with Active Damping
    <a href="{{ site.baseurl }}/assets/Adaptive_Neural_Network_Controller_Paper_ICSV.pdf" target="_blank" title="Read PDF" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s; text-decoration: none; font-size: 0.8em; background-color: #f3f4f6; padding: 4px 8px; border-radius: 4px; color: #0366d6; border: 1px solid #d1d5da;">
      📄 PDF
    </a>
  </h3>
  
  <p style="font-style: italic; color: #586069; margin-top: -10px; margin-bottom: 15px;">
    Archit Sharma, Pravin M. Singru — Published in the 30th International Congress on Sound and Vibration (ICSV30)
  </p>
  
  <p>An adaptive neural network-based controller for a vehicle active suspension system that has a adaptive neural network algorithm implemented for approximation of damper dynamics. The controller was evaluated for improvements in maximum overshoot and settling time across diverse road profiles compared to passive and LQR control methods.</p>
  
</div>