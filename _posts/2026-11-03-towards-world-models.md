---
layout: post
title: Towards World Models
categories: [Ongoing]
---

<p>This is the first stepping stone in a foray into <em>distributional RL</em>. The details of the architecture are still fluid, but I know I will need a distributional learned model of any environment I choose to work with going forward. The two recent designs I would like to work with are <a href="https://arxiv.org/abs/2509.24527" target="_blank">Dreamer 4</a> and <a href="https://arxiv.org/abs/2608.29029" target="_blank">Flow-JEPA</a>.</p>

<p><em>Experiment log, not formal academic work. Conclusions may change as it evolves.</em></p>

<h2>Two Architectures</h2>


<h3>Flow-JEPA style</h3>
<figure style="margin: 10px 0 30px;">
<img src="{{ site.baseurl }}/images/wm/fjepa_overview.svg" alt="Flow-JEPA overview: (a) training pipeline, (b) predictor architecture" style="width: 100%; height: auto;" />
<figcaption style="font-size: 15px; color: #666; margin-top: 6px;">Figure 3 from Huo, Song &amp; Luo, <a href="https://arxiv.org/abs/2608.29029" target="_blank"><em>Flow-JEPA: Robust Latent Dynamics for JEPA World Models via Flow Matching</em></a> (2026), CC BY 4.0.</figcaption>
</figure>

<h3>Dreamer style</h3>
<figure style="margin: 10px 0 30px;">
<img src="{{ site.baseurl }}/images/wm/dreamer4_dynamics.png" alt="Dreamer 4 block-causal dynamics transformer" style="width: 100%; max-width: 424px; height: auto; display: block; margin: 0 auto;" />
<figcaption style="font-size: 15px; color: #666; margin-top: 6px;">Figure 2b from Hafner, Yan &amp; Lillicrap, <a href="https://arxiv.org/abs/2509.24527" target="_blank"><em>Training Agents Inside of Scalable World Models</em></a> (Dreamer 4, 2025).</figcaption>
</figure>

<h2>Experiments</h2>

<h3>1. Environment: Push-T</h3>

<p>I am using Push-T as (1) a quick prototyping environment where I can judge small changes to the architecture and training recipe, and (2) a test bed to compare against published numbers, as a sanity check that my implementations are accurate. 1 predicted step = 5 frames.</p>

<h4>Reproducing Flow-JEPA planning</h4>

<p>Retrained Flow-JEPA with its CEM (cross-entropy method) planner: reach a goal frame 25 steps ahead within 50 steps, 50 episodes per seed. "Noisy" adds stochasticity to the environment.</p>

<table style="display: block; overflow-x: auto;">
  <tr><th>Model</th><th>CEM iterations</th><th>Clean success (%)</th><th>Noisy success (%)</th></tr>
  <tr><td>Flow-JEPA, my run (20 epochs)</td><td>10</td><td>86.7</td><td>45.3</td></tr>
  <tr><td>Flow-JEPA, my run (20 epochs)</td><td>30</td><td></td><td>49.3</td></tr>
  <tr><td>Flow-JEPA, my run (10 epochs)</td><td>10</td><td></td><td>45.3</td></tr>
  <tr><td>LeWM, released weights</td><td>30</td><td>88.0</td><td>56.7</td></tr>
  <tr><td>Paper: Flow-JEPA / LeWM</td><td></td><td>96 / 96</td><td>90 / 58</td></tr>
</table>
<figure style="margin: 14px 0 20px;">
<svg viewBox="0 0 680 280" role="img" aria-label="Planning success (%)" style="width:100%;height:auto;display:block" font-family="Helvetica, Arial, sans-serif">
<rect width="680" height="280" fill="#fff"/>
<line x1="58" y1="16" x2="80" y2="16" stroke="#2a78d6" stroke-width="10"/>
<text x="86" y="20" font-size="12" fill="#222">Flow-JEPA, mine</text>
<line x1="193.0" y1="16" x2="215.0" y2="16" stroke="#9fc3ec" stroke-width="10"/>
<text x="221.0" y="20" font-size="12" fill="#222">Flow-JEPA, paper</text>
<line x1="334.6" y1="16" x2="356.6" y2="16" stroke="#eb6834" stroke-width="10"/>
<text x="362.6" y="20" font-size="12" fill="#222">LeWM, mine</text>
<line x1="436.6" y1="16" x2="458.6" y2="16" stroke="#f5b294" stroke-width="10"/>
<text x="464.6" y="20" font-size="12" fill="#222">LeWM, paper</text>
<line x1="58" x2="660" y1="240.0" y2="240.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="244.0" font-size="11" fill="#666" text-anchor="end">0</text>
<line x1="58" x2="660" y1="193.0" y2="193.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="197.0" font-size="11" fill="#666" text-anchor="end">25</text>
<line x1="58" x2="660" y1="146.0" y2="146.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="150.0" font-size="11" fill="#666" text-anchor="end">50</text>
<line x1="58" x2="660" y1="99.0" y2="99.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="103.0" font-size="11" fill="#666" text-anchor="end">75</text>
<line x1="58" x2="660" y1="52.0" y2="52.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="56.0" font-size="11" fill="#666" text-anchor="end">100</text>
<text x="58" y="40" font-size="12" fill="#666">Planning success (%)</text>
<path d="M156.5,240.0 L156.5,81.0 Q156.5,77.0 160.5,77.0 L176.5,77.0 Q180.5,77.0 180.5,81.0 L180.5,240.0 Z" fill="#2a78d6"><title>Flow-JEPA, mine · Clean: 86.7</title></path>
<text x="168.5" y="72.0" font-size="10.5" fill="#222" text-anchor="middle">86.7</text>
<path d="M182.5,240.0 L182.5,63.5 Q182.5,59.5 186.5,59.5 L202.5,59.5 Q206.5,59.5 206.5,63.5 L206.5,240.0 Z" fill="#9fc3ec"><title>Flow-JEPA, paper · Clean: 96</title></path>
<text x="194.5" y="54.5" font-size="10.5" fill="#222" text-anchor="middle">96</text>
<path d="M208.5,240.0 L208.5,78.6 Q208.5,74.6 212.5,74.6 L228.5,74.6 Q232.5,74.6 232.5,78.6 L232.5,240.0 Z" fill="#eb6834"><title>LeWM, mine · Clean: 88</title></path>
<text x="220.5" y="69.6" font-size="10.5" fill="#222" text-anchor="middle">88</text>
<path d="M234.5,240.0 L234.5,63.5 Q234.5,59.5 238.5,59.5 L254.5,59.5 Q258.5,59.5 258.5,63.5 L258.5,240.0 Z" fill="#f5b294"><title>LeWM, paper · Clean: 96</title></path>
<text x="246.5" y="54.5" font-size="10.5" fill="#222" text-anchor="middle">96</text>
<text x="208.5" y="258" font-size="12" fill="#666" text-anchor="middle">Clean</text>
<path d="M457.5,240.0 L457.5,158.8 Q457.5,154.8 461.5,154.8 L477.5,154.8 Q481.5,154.8 481.5,158.8 L481.5,240.0 Z" fill="#2a78d6"><title>Flow-JEPA, mine · Noisy (patch radius 10): 45.3</title></path>
<text x="469.5" y="149.8" font-size="10.5" fill="#222" text-anchor="middle">45.3</text>
<path d="M483.5,240.0 L483.5,74.8 Q483.5,70.8 487.5,70.8 L503.5,70.8 Q507.5,70.8 507.5,74.8 L507.5,240.0 Z" fill="#9fc3ec"><title>Flow-JEPA, paper · Noisy (patch radius 10): 90</title></path>
<text x="495.5" y="65.8" font-size="10.5" fill="#222" text-anchor="middle">90</text>
<path d="M509.5,240.0 L509.5,137.4 Q509.5,133.4 513.5,133.4 L529.5,133.4 Q533.5,133.4 533.5,137.4 L533.5,240.0 Z" fill="#eb6834"><title>LeWM, mine · Noisy (patch radius 10): 56.7</title></path>
<text x="521.5" y="128.4" font-size="10.5" fill="#222" text-anchor="middle">56.7</text>
<path d="M535.5,240.0 L535.5,135.0 Q535.5,131.0 539.5,131.0 L555.5,131.0 Q559.5,131.0 559.5,135.0 L559.5,240.0 Z" fill="#f5b294"><title>LeWM, paper · Noisy (patch radius 10): 58</title></path>
<text x="547.5" y="126.0" font-size="10.5" fill="#222" text-anchor="middle">58</text>
<text x="509.5" y="258" font-size="12" fill="#666" text-anchor="middle">Noisy (patch radius 10)</text>
</svg></figure>

<div style="display: flex; flex-wrap: wrap; gap: 16px; margin: 10px 0 6px;">
  <figure style="flex: 1 1 300px; margin: 0;">
    <video src="{{ site.baseurl }}/images/wm/pusht_plan_clean.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video>
    
  </figure>
  <figure style="flex: 1 1 300px; margin: 0;">
    <video src="{{ site.baseurl }}/images/wm/pusht_plan_noisy.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video>
    
  </figure>
</div>

<figure style="margin: 20px 0 30px;">
  <img src="{{ site.baseurl }}/images/wm/pusht_predictions.jpg" alt="Flow-JEPA Push-T predictions decoded to pixels" style="width: 100%; height: auto;" />
  <figcaption style="font-size: 15px; color: #666;">Flow-JEPA predictions decoded to pixels with a separately trained decoder, out to 25 frames. The model stays relatively accurate even 30 timesteps into the future.</figcaption>
</figure>

<h4>1.1 Predictor ablations</h4>

<p>Once the sanity check confirmed the models were behaving roughly as reported, I ran ablations to find the effects of state history, training horizon length, and action conditioning on model accuracy, and whether one model benefits more from these factors than the other. Training recipe: 20 epochs (263k steps), batch 128, ~16M params, seed 0. Held-out metrics: latent MSE at the first and last predicted step, and block position error from a small probe on the predicted latent. Lower is better.</p>

<p><strong>A. Action conditioning</strong> (horizon H=5, no history)</p>
<table style="display: block; overflow-x: auto;">
  <tr><th>Model</th><th>Actions</th><th>MSE step 1</th><th>MSE step 5</th><th>Block error step 5 (px)</th><th>Angle error step 5 (°)</th></tr>
  <tr><td>Flow-JEPA</td><td>yes</td><td><strong>0.010</strong></td><td><strong>0.058</strong></td><td><strong>4.7</strong></td><td><strong>1.8</strong></td></tr>
  <tr><td>Dreamer</td><td>yes</td><td>0.057</td><td>0.220</td><td>9.9</td><td>4.1</td></tr>
  <tr><td>Flow-JEPA</td><td>no</td><td>0.052</td><td>0.280</td><td>8.5</td><td>3.6</td></tr>
  <tr><td>Dreamer</td><td>no</td><td>0.134</td><td>0.491</td><td>15.9</td><td>7.0</td></tr>
</table>
<figure style="margin: 14px 0 20px;">
<svg viewBox="0 0 680 336" role="img" aria-label="Latent MSE by Predicted step" style="width:100%;height:auto;display:block" font-family="Helvetica, Arial, sans-serif">
<rect width="680" height="336" fill="#fff"/>
<line x1="58" y1="14" x2="80" y2="14" stroke="#2a78d6" stroke-width="2"/>
<text x="86" y="18" font-size="12" fill="#222">Flow-JEPA, actions</text>
<line x1="212.8" y1="14" x2="234.8" y2="14" stroke="#eb6834" stroke-width="2"/>
<text x="240.8" y="18" font-size="12" fill="#222">Dreamer, actions</text>
<line x1="354.4" y1="14" x2="376.4" y2="14" stroke="#2a78d6" stroke-width="2" stroke-dasharray="6 4"/>
<text x="382.4" y="18" font-size="12" fill="#222">Flow-JEPA, no actions</text>
<line x1="58" y1="32" x2="80" y2="32" stroke="#eb6834" stroke-width="2" stroke-dasharray="6 4"/>
<text x="86" y="36" font-size="12" fill="#222">Dreamer, no actions</text>
<line x1="58" x2="530" y1="290.0" y2="290.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="294.0" font-size="11" fill="#666" text-anchor="end">0</text>
<line x1="58" x2="530" y1="236.5" y2="236.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="240.5" font-size="11" fill="#666" text-anchor="end">0.15</text>
<line x1="58" x2="530" y1="183.0" y2="183.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="187.0" font-size="11" fill="#666" text-anchor="end">0.3</text>
<line x1="58" x2="530" y1="129.5" y2="129.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="133.5" font-size="11" fill="#666" text-anchor="end">0.45</text>
<line x1="58" x2="530" y1="76.0" y2="76.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="80.0" font-size="11" fill="#666" text-anchor="end">0.6</text>
<text x="58.0" y="308" font-size="11" fill="#666" text-anchor="middle">1</text>
<text x="176.0" y="308" font-size="11" fill="#666" text-anchor="middle">2</text>
<text x="294.0" y="308" font-size="11" fill="#666" text-anchor="middle">3</text>
<text x="412.0" y="308" font-size="11" fill="#666" text-anchor="middle">4</text>
<text x="530.0" y="308" font-size="11" fill="#666" text-anchor="middle">5</text>
<text x="294.0" y="328" font-size="12" fill="#666" text-anchor="middle">Predicted step</text>
<text x="58" y="62" font-size="12" fill="#666">Latent MSE</text>
<path d="M58.0,286.4 L176.0,283.9 L294.0,280.4 L412.0,275.4 L530.0,269.3" fill="none" stroke="#2a78d6" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
<circle cx="58.0" cy="286.4" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 1: 0.01</title></circle>
<circle cx="176.0" cy="283.9" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 2: 0.017</title></circle>
<circle cx="294.0" cy="280.4" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 3: 0.027</title></circle>
<circle cx="412.0" cy="275.4" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 4: 0.041</title></circle>
<circle cx="530.0" cy="269.3" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 5: 0.058</title></circle>
<path d="M58.0,269.7 L176.0,257.2 L294.0,242.6 L412.0,227.2 L530.0,211.5" fill="none" stroke="#eb6834" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
<circle cx="58.0" cy="269.7" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 1: 0.057</title></circle>
<circle cx="176.0" cy="257.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 2: 0.092</title></circle>
<circle cx="294.0" cy="242.6" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 3: 0.133</title></circle>
<circle cx="412.0" cy="227.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 4: 0.176</title></circle>
<circle cx="530.0" cy="211.5" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 5: 0.22</title></circle>
<path d="M58.0,271.5 L176.0,250.1 L294.0,228.7 L412.0,209.4 L530.0,190.1" fill="none" stroke="#2a78d6" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" stroke-dasharray="6 4"/>
<circle cx="58.0" cy="271.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 1: 0.052</title></circle>
<circle cx="176.0" cy="250.1" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 2: 0.112</title></circle>
<circle cx="294.0" cy="228.7" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 3: 0.172</title></circle>
<circle cx="412.0" cy="209.4" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 4: 0.226</title></circle>
<circle cx="530.0" cy="190.1" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 5: 0.28</title></circle>
<path d="M58.0,242.2 L176.0,205.8 L294.0,171.6 L412.0,141.6 L530.0,114.9" fill="none" stroke="#eb6834" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" stroke-dasharray="6 4"/>
<circle cx="58.0" cy="242.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 1: 0.134</title></circle>
<circle cx="176.0" cy="205.8" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 2: 0.236</title></circle>
<circle cx="294.0" cy="171.6" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 3: 0.332</title></circle>
<circle cx="412.0" cy="141.6" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 4: 0.416</title></circle>
<circle cx="530.0" cy="114.9" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 5: 0.491</title></circle>
<text x="540" y="118.9" font-size="12" fill="#222">Dreamer, no actions</text>
<text x="540" y="194.1" font-size="12" fill="#222">Flow-JEPA, no actions</text>
<text x="540" y="215.5" font-size="12" fill="#222">Dreamer, actions</text>
<text x="540" y="273.3" font-size="12" fill="#222">Flow-JEPA, actions</text>
</svg></figure>
<p>Flow-JEPA beats Dreamer in both settings.</p>

<p><strong>H. Training horizon</strong> (no history)</p>
<table style="display: block; overflow-x: auto;">
  <tr><th>Model</th><th>Actions</th><th>Horizon</th><th>MSE step 1</th><th>MSE last step</th><th>Block error last step (px)</th></tr>
  <tr><td>Flow-JEPA</td><td>yes</td><td>1</td><td><strong>0.007</strong></td><td>0.007</td><td>2.5</td></tr>
  <tr><td>Flow-JEPA</td><td>yes</td><td>8</td><td>0.012</td><td>0.159</td><td>7.2</td></tr>
  <tr><td>Flow-JEPA</td><td>yes</td><td>16</td><td>0.015</td><td>0.395</td><td>9.9</td></tr>
  <tr><td>Dreamer</td><td>yes</td><td>1</td><td>0.058</td><td>0.058</td><td>5.7</td></tr>
  <tr><td>Dreamer</td><td>yes</td><td>8</td><td>0.054</td><td>0.355</td><td>11.3</td></tr>
  <tr><td>Dreamer</td><td>yes</td><td>16</td><td>0.060</td><td>0.576</td><td>13.0</td></tr>
  <tr><td>Flow-JEPA</td><td>no</td><td>1</td><td>0.046</td><td>0.046</td><td>3.0</td></tr>
  <tr><td>Flow-JEPA</td><td>no</td><td>8</td><td>0.060</td><td>0.434</td><td>12.0</td></tr>
  <tr><td>Flow-JEPA</td><td>no</td><td>16</td><td>0.063</td><td>0.640</td><td>16.5</td></tr>
  <tr><td>Dreamer</td><td>no</td><td>1</td><td>0.111</td><td>0.111</td><td>6.7</td></tr>
  <tr><td>Dreamer</td><td>no</td><td>8</td><td>0.138</td><td>0.663</td><td>19.4</td></tr>
  <tr><td>Dreamer</td><td>no</td><td>16</td><td>0.154</td><td>0.955</td><td>43.5</td></tr>
</table>
<figure style="margin: 14px 0 20px;">
<svg viewBox="0 0 680 336" role="img" aria-label="Latent MSE (trained with H = 16) by Predicted step" style="width:100%;height:auto;display:block" font-family="Helvetica, Arial, sans-serif">
<rect width="680" height="336" fill="#fff"/>
<line x1="58" y1="14" x2="80" y2="14" stroke="#2a78d6" stroke-width="2"/>
<text x="86" y="18" font-size="12" fill="#222">Flow-JEPA, actions</text>
<line x1="212.8" y1="14" x2="234.8" y2="14" stroke="#eb6834" stroke-width="2"/>
<text x="240.8" y="18" font-size="12" fill="#222">Dreamer, actions</text>
<line x1="354.4" y1="14" x2="376.4" y2="14" stroke="#2a78d6" stroke-width="2" stroke-dasharray="6 4"/>
<text x="382.4" y="18" font-size="12" fill="#222">Flow-JEPA, no actions</text>
<line x1="58" y1="32" x2="80" y2="32" stroke="#eb6834" stroke-width="2" stroke-dasharray="6 4"/>
<text x="86" y="36" font-size="12" fill="#222">Dreamer, no actions</text>
<line x1="58" x2="530" y1="290.0" y2="290.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="294.0" font-size="11" fill="#666" text-anchor="end">0</text>
<line x1="58" x2="530" y1="236.5" y2="236.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="240.5" font-size="11" fill="#666" text-anchor="end">0.25</text>
<line x1="58" x2="530" y1="183.0" y2="183.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="187.0" font-size="11" fill="#666" text-anchor="end">0.5</text>
<line x1="58" x2="530" y1="129.5" y2="129.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="133.5" font-size="11" fill="#666" text-anchor="end">0.75</text>
<line x1="58" x2="530" y1="76.0" y2="76.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="80.0" font-size="11" fill="#666" text-anchor="end">1</text>
<text x="58.0" y="308" font-size="11" fill="#666" text-anchor="middle">1</text>
<text x="89.5" y="308" font-size="11" fill="#666" text-anchor="middle">2</text>
<text x="120.9" y="308" font-size="11" fill="#666" text-anchor="middle">3</text>
<text x="152.4" y="308" font-size="11" fill="#666" text-anchor="middle">4</text>
<text x="183.9" y="308" font-size="11" fill="#666" text-anchor="middle">5</text>
<text x="215.3" y="308" font-size="11" fill="#666" text-anchor="middle">6</text>
<text x="246.8" y="308" font-size="11" fill="#666" text-anchor="middle">7</text>
<text x="278.3" y="308" font-size="11" fill="#666" text-anchor="middle">8</text>
<text x="309.7" y="308" font-size="11" fill="#666" text-anchor="middle">9</text>
<text x="341.2" y="308" font-size="11" fill="#666" text-anchor="middle">10</text>
<text x="372.7" y="308" font-size="11" fill="#666" text-anchor="middle">11</text>
<text x="404.1" y="308" font-size="11" fill="#666" text-anchor="middle">12</text>
<text x="435.6" y="308" font-size="11" fill="#666" text-anchor="middle">13</text>
<text x="467.1" y="308" font-size="11" fill="#666" text-anchor="middle">14</text>
<text x="498.5" y="308" font-size="11" fill="#666" text-anchor="middle">15</text>
<text x="530.0" y="308" font-size="11" fill="#666" text-anchor="middle">16</text>
<text x="294.0" y="328" font-size="12" fill="#666" text-anchor="middle">Predicted step</text>
<text x="58" y="62" font-size="12" fill="#666">Latent MSE (trained with H = 16)</text>
<path d="M58.0,286.8 L89.5,284.4 L120.9,281.0 L152.4,276.7 L183.9,271.8 L215.3,266.5 L246.8,260.5 L278.3,253.8 L309.7,247.4 L341.2,241.2 L372.7,234.8 L404.1,227.7 L435.6,221.5 L467.1,215.7 L498.5,210.6 L530.0,205.5" fill="none" stroke="#2a78d6" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
<circle cx="58.0" cy="286.8" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 1: 0.015</title></circle>
<circle cx="89.5" cy="284.4" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 2: 0.026</title></circle>
<circle cx="120.9" cy="281.0" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 3: 0.042</title></circle>
<circle cx="152.4" cy="276.7" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 4: 0.062</title></circle>
<circle cx="183.9" cy="271.8" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 5: 0.085</title></circle>
<circle cx="215.3" cy="266.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 6: 0.11</title></circle>
<circle cx="246.8" cy="260.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 7: 0.138</title></circle>
<circle cx="278.3" cy="253.8" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 8: 0.169</title></circle>
<circle cx="309.7" cy="247.4" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 9: 0.199</title></circle>
<circle cx="341.2" cy="241.2" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 10: 0.228</title></circle>
<circle cx="372.7" cy="234.8" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 11: 0.258</title></circle>
<circle cx="404.1" cy="227.7" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 12: 0.291</title></circle>
<circle cx="435.6" cy="221.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 13: 0.32</title></circle>
<circle cx="467.1" cy="215.7" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 14: 0.347</title></circle>
<circle cx="498.5" cy="210.6" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 15: 0.371</title></circle>
<circle cx="530.0" cy="205.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Predicted step 16: 0.395</title></circle>
<path d="M58.0,277.2 L89.5,268.4 L120.9,258.8 L152.4,249.1 L183.9,239.5 L215.3,230.7 L246.8,221.3 L278.3,212.7 L309.7,205.7 L341.2,199.7 L372.7,193.3 L404.1,186.9 L435.6,181.3 L467.1,176.4 L498.5,171.2 L530.0,166.7" fill="none" stroke="#eb6834" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
<circle cx="58.0" cy="277.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 1: 0.06</title></circle>
<circle cx="89.5" cy="268.4" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 2: 0.101</title></circle>
<circle cx="120.9" cy="258.8" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 3: 0.146</title></circle>
<circle cx="152.4" cy="249.1" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 4: 0.191</title></circle>
<circle cx="183.9" cy="239.5" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 5: 0.236</title></circle>
<circle cx="215.3" cy="230.7" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 6: 0.277</title></circle>
<circle cx="246.8" cy="221.3" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 7: 0.321</title></circle>
<circle cx="278.3" cy="212.7" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 8: 0.361</title></circle>
<circle cx="309.7" cy="205.7" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 9: 0.394</title></circle>
<circle cx="341.2" cy="199.7" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 10: 0.422</title></circle>
<circle cx="372.7" cy="193.3" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 11: 0.452</title></circle>
<circle cx="404.1" cy="186.9" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 12: 0.482</title></circle>
<circle cx="435.6" cy="181.3" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 13: 0.508</title></circle>
<circle cx="467.1" cy="176.4" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 14: 0.531</title></circle>
<circle cx="498.5" cy="171.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 15: 0.555</title></circle>
<circle cx="530.0" cy="166.7" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Predicted step 16: 0.576</title></circle>
<path d="M58.0,276.5 L89.5,261.3 L120.9,246.1 L152.4,232.4 L183.9,220.0 L215.3,211.2 L246.8,203.5 L278.3,195.6 L309.7,189.8 L341.2,184.3 L372.7,179.1 L404.1,175.1 L435.6,169.3 L467.1,165.0 L498.5,159.5 L530.0,153.0" fill="none" stroke="#2a78d6" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" stroke-dasharray="6 4"/>
<circle cx="58.0" cy="276.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 1: 0.063</title></circle>
<circle cx="89.5" cy="261.3" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 2: 0.134</title></circle>
<circle cx="120.9" cy="246.1" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 3: 0.205</title></circle>
<circle cx="152.4" cy="232.4" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 4: 0.269</title></circle>
<circle cx="183.9" cy="220.0" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 5: 0.327</title></circle>
<circle cx="215.3" cy="211.2" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 6: 0.368</title></circle>
<circle cx="246.8" cy="203.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 7: 0.404</title></circle>
<circle cx="278.3" cy="195.6" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 8: 0.441</title></circle>
<circle cx="309.7" cy="189.8" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 9: 0.468</title></circle>
<circle cx="341.2" cy="184.3" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 10: 0.494</title></circle>
<circle cx="372.7" cy="179.1" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 11: 0.518</title></circle>
<circle cx="404.1" cy="175.1" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 12: 0.537</title></circle>
<circle cx="435.6" cy="169.3" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 13: 0.564</title></circle>
<circle cx="467.1" cy="165.0" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 14: 0.584</title></circle>
<circle cx="498.5" cy="159.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 15: 0.61</title></circle>
<circle cx="530.0" cy="153.0" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Predicted step 16: 0.64</title></circle>
<path d="M58.0,257.0 L89.5,230.1 L120.9,207.6 L152.4,188.1 L183.9,171.0 L215.3,156.5 L246.8,144.1 L278.3,133.4 L309.7,125.4 L341.2,118.2 L372.7,111.5 L404.1,106.8 L435.6,101.3 L467.1,95.7 L498.5,89.5 L530.0,85.6" fill="none" stroke="#eb6834" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" stroke-dasharray="6 4"/>
<circle cx="58.0" cy="257.0" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 1: 0.154</title></circle>
<circle cx="89.5" cy="230.1" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 2: 0.28</title></circle>
<circle cx="120.9" cy="207.6" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 3: 0.385</title></circle>
<circle cx="152.4" cy="188.1" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 4: 0.476</title></circle>
<circle cx="183.9" cy="171.0" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 5: 0.556</title></circle>
<circle cx="215.3" cy="156.5" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 6: 0.624</title></circle>
<circle cx="246.8" cy="144.1" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 7: 0.682</title></circle>
<circle cx="278.3" cy="133.4" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 8: 0.732</title></circle>
<circle cx="309.7" cy="125.4" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 9: 0.769</title></circle>
<circle cx="341.2" cy="118.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 10: 0.803</title></circle>
<circle cx="372.7" cy="111.5" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 11: 0.834</title></circle>
<circle cx="404.1" cy="106.8" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 12: 0.856</title></circle>
<circle cx="435.6" cy="101.3" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 13: 0.882</title></circle>
<circle cx="467.1" cy="95.7" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 14: 0.908</title></circle>
<circle cx="498.5" cy="89.5" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 15: 0.937</title></circle>
<circle cx="530.0" cy="85.6" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Predicted step 16: 0.955</title></circle>
<text x="540" y="89.6" font-size="12" fill="#222">Dreamer, no actions</text>
<text x="540" y="157.0" font-size="12" fill="#222">Flow-JEPA, no actions</text>
<text x="540" y="172.0" font-size="12" fill="#222">Dreamer, actions</text>
<text x="540" y="209.5" font-size="12" fill="#222">Flow-JEPA, actions</text>
</svg></figure>
<figure style="margin: 14px 0 20px;">
<svg viewBox="0 0 680 336" role="img" aria-label="Latent MSE at step 1 by Training horizon H" style="width:100%;height:auto;display:block" font-family="Helvetica, Arial, sans-serif">
<rect width="680" height="336" fill="#fff"/>
<line x1="58" y1="14" x2="80" y2="14" stroke="#2a78d6" stroke-width="2"/>
<text x="86" y="18" font-size="12" fill="#222">Flow-JEPA, actions</text>
<line x1="212.8" y1="14" x2="234.8" y2="14" stroke="#eb6834" stroke-width="2"/>
<text x="240.8" y="18" font-size="12" fill="#222">Dreamer, actions</text>
<line x1="354.4" y1="14" x2="376.4" y2="14" stroke="#2a78d6" stroke-width="2" stroke-dasharray="6 4"/>
<text x="382.4" y="18" font-size="12" fill="#222">Flow-JEPA, no actions</text>
<line x1="58" y1="32" x2="80" y2="32" stroke="#eb6834" stroke-width="2" stroke-dasharray="6 4"/>
<text x="86" y="36" font-size="12" fill="#222">Dreamer, no actions</text>
<line x1="58" x2="530" y1="290.0" y2="290.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="294.0" font-size="11" fill="#666" text-anchor="end">0</text>
<line x1="58" x2="530" y1="236.5" y2="236.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="240.5" font-size="11" fill="#666" text-anchor="end">0.05</text>
<line x1="58" x2="530" y1="183.0" y2="183.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="187.0" font-size="11" fill="#666" text-anchor="end">0.1</text>
<line x1="58" x2="530" y1="129.5" y2="129.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="133.5" font-size="11" fill="#666" text-anchor="end">0.15</text>
<line x1="58" x2="530" y1="76.0" y2="76.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="80.0" font-size="11" fill="#666" text-anchor="end">0.2</text>
<text x="58.0" y="308" font-size="11" fill="#666" text-anchor="middle">1</text>
<text x="294.0" y="308" font-size="11" fill="#666" text-anchor="middle">8</text>
<text x="530.0" y="308" font-size="11" fill="#666" text-anchor="middle">16</text>
<text x="294.0" y="328" font-size="12" fill="#666" text-anchor="middle">Training horizon H</text>
<text x="58" y="62" font-size="12" fill="#666">Latent MSE at step 1</text>
<path d="M58.0,282.5 L294.0,277.2 L530.0,273.9" fill="none" stroke="#2a78d6" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
<circle cx="58.0" cy="282.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Training horizon H 1: 0.007</title></circle>
<circle cx="294.0" cy="277.2" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Training horizon H 8: 0.012</title></circle>
<circle cx="530.0" cy="273.9" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, actions · Training horizon H 16: 0.015</title></circle>
<path d="M58.0,227.9 L294.0,232.2 L530.0,225.8" fill="none" stroke="#eb6834" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
<circle cx="58.0" cy="227.9" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Training horizon H 1: 0.058</title></circle>
<circle cx="294.0" cy="232.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Training horizon H 8: 0.054</title></circle>
<circle cx="530.0" cy="225.8" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, actions · Training horizon H 16: 0.06</title></circle>
<path d="M58.0,240.8 L294.0,225.8 L530.0,222.6" fill="none" stroke="#2a78d6" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" stroke-dasharray="6 4"/>
<circle cx="58.0" cy="240.8" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Training horizon H 1: 0.046</title></circle>
<circle cx="294.0" cy="225.8" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Training horizon H 8: 0.06</title></circle>
<circle cx="530.0" cy="222.6" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>Flow-JEPA, no actions · Training horizon H 16: 0.063</title></circle>
<path d="M58.0,171.2 L294.0,142.3 L530.0,125.2" fill="none" stroke="#eb6834" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" stroke-dasharray="6 4"/>
<circle cx="58.0" cy="171.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Training horizon H 1: 0.111</title></circle>
<circle cx="294.0" cy="142.3" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Training horizon H 8: 0.138</title></circle>
<circle cx="530.0" cy="125.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>Dreamer, no actions · Training horizon H 16: 0.154</title></circle>
<text x="540" y="129.2" font-size="12" fill="#222">Dreamer, no actions</text>
<text x="540" y="226.6" font-size="12" fill="#222">Flow-JEPA, no actions</text>
<text x="540" y="241.6" font-size="12" fill="#222">Dreamer, actions</text>
<text x="540" y="277.9" font-size="12" fill="#222">Flow-JEPA, actions</text>
</svg></figure>
<p>Error grows roughly linearly with step, as expected, though the linear trend is optimistic. Longer training horizons cost some earlier-step accuracy.</p>

<p><strong>B. History</strong> (action-conditioned, horizon 5)</p>
<table style="display: block; overflow-x: auto;">
  <tr><th>History (frames)</th><th>Flow-JEPA</th><th>Flow-JEPA + past actions</th><th>Dreamer</th><th>Dreamer + past actions</th></tr>
  <tr><td>1</td><td>0.062</td><td>0.061</td><td>0.209</td><td>0.236</td></tr>
  <tr><td>3</td><td>0.063</td><td>0.060</td><td>0.205</td><td>0.166</td></tr>
  <tr><td>6</td><td>0.066</td><td>0.059</td><td>0.190</td><td>0.179</td></tr>
  <tr><td>12</td><td>0.068</td><td><strong>0.057</strong></td><td>0.187</td><td><strong>0.162</strong></td></tr>
  <tr><td>32</td><td>0.075</td><td>0.061</td><td>0.196</td><td>0.169</td></tr>
</table>
<p style="font-size: 15px; color: #666;">Latent MSE at step 5.</p>
<div style="display: flex; flex-wrap: wrap; gap: 12px; margin: 14px 0 20px;"><div style="flex: 1 1 300px; min-width: 0;">
<svg viewBox="0 0 400 298" role="img" aria-label="Flow-JEPA: latent MSE at step 5 by History (frames)" style="width:100%;height:auto;display:block" font-family="Helvetica, Arial, sans-serif">
<rect width="400" height="298" fill="#fff"/>
<line x1="58" y1="14" x2="80" y2="14" stroke="#2a78d6" stroke-width="2"/>
<text x="86" y="18" font-size="12" fill="#222">+ past actions</text>
<line x1="186.39999999999998" y1="14" x2="208.39999999999998" y2="14" stroke="#2a78d6" stroke-width="2" stroke-dasharray="6 4"/>
<text x="214.39999999999998" y="18" font-size="12" fill="#222">no past actions</text>
<line x1="58" x2="282" y1="252.0" y2="252.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="256.0" font-size="11" fill="#666" text-anchor="end">0</text>
<line x1="58" x2="282" y1="203.5" y2="203.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="207.5" font-size="11" fill="#666" text-anchor="end">0.02</text>
<line x1="58" x2="282" y1="155.0" y2="155.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="159.0" font-size="11" fill="#666" text-anchor="end">0.04</text>
<line x1="58" x2="282" y1="106.5" y2="106.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="110.5" font-size="11" fill="#666" text-anchor="end">0.06</text>
<line x1="58" x2="282" y1="58.0" y2="58.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="62.0" font-size="11" fill="#666" text-anchor="end">0.08</text>
<text x="58.0" y="270" font-size="11" fill="#666" text-anchor="middle">1</text>
<text x="129.0" y="270" font-size="11" fill="#666" text-anchor="middle">3</text>
<text x="173.8" y="270" font-size="11" fill="#666" text-anchor="middle">6</text>
<text x="218.6" y="270" font-size="11" fill="#666" text-anchor="middle">12</text>
<text x="282.0" y="270" font-size="11" fill="#666" text-anchor="middle">32</text>
<text x="170.0" y="290" font-size="12" fill="#666" text-anchor="middle">History (frames)</text>
<text x="58" y="44" font-size="12" fill="#666">Flow-JEPA: latent MSE at step 5</text>
<path d="M58.0,104.1 L129.0,106.5 L173.8,108.9 L218.6,113.8 L282.0,104.1" fill="none" stroke="#2a78d6" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
<circle cx="58.0" cy="104.1" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 1: 0.061</title></circle>
<circle cx="129.0" cy="106.5" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 3: 0.06</title></circle>
<circle cx="173.8" cy="108.9" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 6: 0.059</title></circle>
<circle cx="218.6" cy="113.8" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 12: 0.057</title></circle>
<circle cx="282.0" cy="104.1" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 32: 0.061</title></circle>
<path d="M58.0,101.7 L129.0,99.2 L173.8,91.9 L218.6,87.1 L282.0,70.1" fill="none" stroke="#2a78d6" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" stroke-dasharray="6 4"/>
<circle cx="58.0" cy="101.7" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 1: 0.062</title></circle>
<circle cx="129.0" cy="99.2" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 3: 0.063</title></circle>
<circle cx="173.8" cy="91.9" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 6: 0.066</title></circle>
<circle cx="218.6" cy="87.1" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 12: 0.068</title></circle>
<circle cx="282.0" cy="70.1" r="4" fill="#2a78d6" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 32: 0.075</title></circle>
<text x="292" y="74.1" font-size="12" fill="#222">no past actions</text>
<text x="292" y="108.1" font-size="12" fill="#222">+ past actions</text>
</svg>
</div><div style="flex: 1 1 300px; min-width: 0;">
<svg viewBox="0 0 400 298" role="img" aria-label="Dreamer: latent MSE at step 5 by History (frames)" style="width:100%;height:auto;display:block" font-family="Helvetica, Arial, sans-serif">
<rect width="400" height="298" fill="#fff"/>
<line x1="58" y1="14" x2="80" y2="14" stroke="#eb6834" stroke-width="2"/>
<text x="86" y="18" font-size="12" fill="#222">+ past actions</text>
<line x1="186.39999999999998" y1="14" x2="208.39999999999998" y2="14" stroke="#eb6834" stroke-width="2" stroke-dasharray="6 4"/>
<text x="214.39999999999998" y="18" font-size="12" fill="#222">no past actions</text>
<line x1="58" x2="282" y1="252.0" y2="252.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="256.0" font-size="11" fill="#666" text-anchor="end">0</text>
<line x1="58" x2="282" y1="203.5" y2="203.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="207.5" font-size="11" fill="#666" text-anchor="end">0.062</text>
<line x1="58" x2="282" y1="155.0" y2="155.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="159.0" font-size="11" fill="#666" text-anchor="end">0.125</text>
<line x1="58" x2="282" y1="106.5" y2="106.5" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="110.5" font-size="11" fill="#666" text-anchor="end">0.188</text>
<line x1="58" x2="282" y1="58.0" y2="58.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="62.0" font-size="11" fill="#666" text-anchor="end">0.25</text>
<text x="58.0" y="270" font-size="11" fill="#666" text-anchor="middle">1</text>
<text x="129.0" y="270" font-size="11" fill="#666" text-anchor="middle">3</text>
<text x="173.8" y="270" font-size="11" fill="#666" text-anchor="middle">6</text>
<text x="218.6" y="270" font-size="11" fill="#666" text-anchor="middle">12</text>
<text x="282.0" y="270" font-size="11" fill="#666" text-anchor="middle">32</text>
<text x="170.0" y="290" font-size="12" fill="#666" text-anchor="middle">History (frames)</text>
<text x="58" y="44" font-size="12" fill="#666">Dreamer: latent MSE at step 5</text>
<path d="M58.0,68.9 L129.0,123.2 L173.8,113.1 L218.6,126.3 L282.0,120.9" fill="none" stroke="#eb6834" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
<circle cx="58.0" cy="68.9" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 1: 0.236</title></circle>
<circle cx="129.0" cy="123.2" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 3: 0.166</title></circle>
<circle cx="173.8" cy="113.1" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 6: 0.179</title></circle>
<circle cx="218.6" cy="126.3" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 12: 0.162</title></circle>
<circle cx="282.0" cy="120.9" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>+ past actions · History (frames) 32: 0.169</title></circle>
<path d="M58.0,89.8 L129.0,92.9 L173.8,104.6 L218.6,106.9 L282.0,99.9" fill="none" stroke="#eb6834" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" stroke-dasharray="6 4"/>
<circle cx="58.0" cy="89.8" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 1: 0.209</title></circle>
<circle cx="129.0" cy="92.9" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 3: 0.205</title></circle>
<circle cx="173.8" cy="104.6" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 6: 0.19</title></circle>
<circle cx="218.6" cy="106.9" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 12: 0.187</title></circle>
<circle cx="282.0" cy="99.9" r="4" fill="#eb6834" stroke="#fff" stroke-width="2"><title>no past actions · History (frames) 32: 0.196</title></circle>
<text x="292" y="103.9" font-size="12" fill="#222">no past actions</text>
<text x="292" y="124.9" font-size="12" fill="#222">+ past actions</text>
</svg></div></div>
<p>History helps Dreamer significantly, Flow-JEPA barely. Past actions help both when included in the history. Classical theory suggests both models should benefit from history. My current hypothesis is that the environment is too simple for history to appreciably improve Flow-JEPA. I will probably repeat this ablation on OCBench and real-robot data.</p>

<p><strong>Positional encoding</strong> (Flow-JEPA, 12 frames + past actions)</p>
<table style="display: block; overflow-x: auto;">
  <tr><th>Positions</th><th>MSE step 1</th><th>MSE step 5</th><th>Block error step 5 (px)</th></tr>
  <tr><td>RoPE over time</td><td>0.009</td><td><strong>0.057</strong></td><td><strong>4.2</strong></td></tr>
  <tr><td>None (NoPE)</td><td>0.010</td><td>0.062</td><td>4.4</td></tr>
</table>
<p>RoPE performs better than NoPE (no positional embedding), as expected.</p>

<h3>2. Environment: OCBench</h3>

<p>A simulated manipulation benchmark was needed to bridge the implementation gap between Push-T and real-robot data. <a href="https://arxiv.org/abs/2610.07056" target="_blank">OCBench</a> (<a href="https://github.com/seohongpark/ocbench" target="_blank">code</a>) is a simulated 3D robot-arm benchmark with cubes, a Tower of Hanoi, buttons, drawers and windows. Training data: four tasks (block-single, hanoi-single, block-double, chamber-easy task 2), 1,000 episodes each, 10 Hz action rate.</p>

<h4>2.1 Encoder</h4>

<p>The LeWM encoder is Push-T-specific, so OCBench needs a general image encoder.</p>
<ul>
  <li><strong>Pooled DINOv2 failed.</strong> Pooling frozen DINOv2-S patch tokens to a 4×4 grid (also used on the real robot) lost too much detail, as expected.</li>
  <li><strong>Current: frozen DINOv3 ViT-S, full patch grid</strong>, front camera, plus 7-d end-effector state (position, yaw, gripper opening, contact).</li>
  <li><strong>No custom encoder.</strong> Literature suggests custom-trained encoders match the performance of pretrained ones (and may beat them in certain scenarios), but they are out of scope for this project.</li>
</ul>

<h4>2.2 Decoder ablations</h4>

<p>A pixel decoder maps frozen DINOv3 tokens back to images, following Dreamer 4: deterministic transformer (12 blocks, width 768, ~115M params), MSE + 0.2·LPIPS, 100k steps. Ablations were mainly needed because naive decoders tend to lose track of the target object, conjuring it from thin air while it is in use. I compare different methods of semantic grounding.</p>

<table style="display: block; overflow-x: auto;">
  <tr><th>Grounding</th><th>Eval</th><th>block-single</th><th>hanoi-single</th><th>block-double</th><th>chamber-easy</th><th>All (PSNR / LPIPS)</th></tr>
  <tr><td>Box</td><td>with objects</td><td>34.50</td><td>37.55</td><td>33.82</td><td>30.92</td><td><strong>33.58</strong> / 0.0213</td></tr>
  <tr><td>Box</td><td>no objects</td><td>34.23</td><td>37.32</td><td>33.43</td><td>30.66</td><td>33.29 / 0.0219</td></tr>
  <tr><td>Mask</td><td>with objects</td><td>34.23</td><td>37.47</td><td>33.39</td><td>30.72</td><td>33.32 / <strong>0.0204</strong></td></tr>
  <tr><td>Mask</td><td>no objects</td><td>34.20</td><td>37.36</td><td>33.35</td><td>30.68</td><td>33.28 / 0.0208</td></tr>
</table>
<p style="font-size: 15px; color: #666;">PSNR in dB (higher is better) per task; LPIPS lower is better. 256 validation frames per task, step 100k.</p>
<figure style="margin: 14px 0 20px;">
<svg viewBox="0 0 680 280" role="img" aria-label="PSNR gain from object grounding (dB)" style="width:100%;height:auto;display:block" font-family="Helvetica, Arial, sans-serif">
<rect width="680" height="280" fill="#fff"/>
<line x1="58" y1="16" x2="80" y2="16" stroke="#2a78d6" stroke-width="10"/>
<text x="86" y="20" font-size="12" fill="#222">Box grounding</text>
<line x1="179.8" y1="16" x2="201.8" y2="16" stroke="#eb6834" stroke-width="10"/>
<text x="207.8" y="20" font-size="12" fill="#222">Mask grounding</text>
<line x1="58" x2="660" y1="240.0" y2="240.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="244.0" font-size="11" fill="#666" text-anchor="end">0.00</text>
<line x1="58" x2="660" y1="193.0" y2="193.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="197.0" font-size="11" fill="#666" text-anchor="end">0.12</text>
<line x1="58" x2="660" y1="146.0" y2="146.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="150.0" font-size="11" fill="#666" text-anchor="end">0.25</text>
<line x1="58" x2="660" y1="99.0" y2="99.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="103.0" font-size="11" fill="#666" text-anchor="end">0.38</text>
<line x1="58" x2="660" y1="52.0" y2="52.0" stroke="#e6e6e6" stroke-width="1"/>
<text x="50" y="56.0" font-size="11" fill="#666" text-anchor="end">0.50</text>
<text x="58" y="40" font-size="12" fill="#666">PSNR gain from object grounding (dB)</text>
<path d="M92.2,240.0 L92.2,144.4 Q92.2,140.4 96.2,140.4 L112.2,140.4 Q116.2,140.4 116.2,144.4 L116.2,240.0 Z" fill="#2a78d6"><title>Box grounding · block-single: 0.27</title></path>
<text x="104.2" y="135.4" font-size="10.5" fill="#222" text-anchor="middle">0.27</text>
<path d="M118.2,240.0 L118.2,232.0 Q118.2,228.0 122.2,228.0 L138.2,228.0 Q142.2,228.0 142.2,232.0 L142.2,240.0 Z" fill="#eb6834"><title>Mask grounding · block-single: 0.03</title></path>
<text x="130.2" y="223.0" font-size="10.5" fill="#222" text-anchor="middle">0.03</text>
<text x="118.2" y="258" font-size="12" fill="#666" text-anchor="middle">block-single</text>
<path d="M212.6,240.0 L212.6,159.8 Q212.6,155.8 216.6,155.8 L232.6,155.8 Q236.6,155.8 236.6,159.8 L236.6,240.0 Z" fill="#2a78d6"><title>Box grounding · hanoi-single: 0.22</title></path>
<text x="224.6" y="150.8" font-size="10.5" fill="#222" text-anchor="middle">0.22</text>
<path d="M238.6,240.0 L238.6,201.5 Q238.6,197.5 242.6,197.5 L258.6,197.5 Q262.6,197.5 262.6,201.5 L262.6,240.0 Z" fill="#eb6834"><title>Mask grounding · hanoi-single: 0.11</title></path>
<text x="250.6" y="192.5" font-size="10.5" fill="#222" text-anchor="middle">0.11</text>
<text x="238.6" y="258" font-size="12" fill="#666" text-anchor="middle">hanoi-single</text>
<path d="M333.0,240.0 L333.0,94.4 Q333.0,90.4 337.0,90.4 L353.0,90.4 Q357.0,90.4 357.0,94.4 L357.0,240.0 Z" fill="#2a78d6"><title>Box grounding · block-double: 0.40</title></path>
<text x="345.0" y="85.4" font-size="10.5" fill="#222" text-anchor="middle">0.40</text>
<path d="M359.0,240.0 L359.0,228.2 Q359.0,224.2 363.0,224.2 L379.0,224.2 Q383.0,224.2 383.0,228.2 L383.0,240.0 Z" fill="#eb6834"><title>Mask grounding · block-double: 0.04</title></path>
<text x="371.0" y="219.2" font-size="10.5" fill="#222" text-anchor="middle">0.04</text>
<text x="359.0" y="258" font-size="12" fill="#666" text-anchor="middle">block-double</text>
<path d="M453.4,240.0 L453.4,143.6 Q453.4,139.6 457.4,139.6 L473.4,139.6 Q477.4,139.6 477.4,143.6 L477.4,240.0 Z" fill="#2a78d6"><title>Box grounding · chamber-easy: 0.27</title></path>
<text x="465.4" y="134.6" font-size="10.5" fill="#222" text-anchor="middle">0.27</text>
<path d="M479.4,240.0 L479.4,229.3 Q479.4,225.3 483.4,225.3 L499.4,225.3 Q503.4,225.3 503.4,229.3 L503.4,240.0 Z" fill="#eb6834"><title>Mask grounding · chamber-easy: 0.04</title></path>
<text x="491.4" y="220.3" font-size="10.5" fill="#222" text-anchor="middle">0.04</text>
<text x="479.4" y="258" font-size="12" fill="#666" text-anchor="middle">chamber-easy</text>
<path d="M573.8,240.0 L573.8,133.8 Q573.8,129.8 577.8,129.8 L593.8,129.8 Q597.8,129.8 597.8,133.8 L597.8,240.0 Z" fill="#2a78d6"><title>Box grounding · All: 0.29</title></path>
<text x="585.8" y="124.8" font-size="10.5" fill="#222" text-anchor="middle">0.29</text>
<path d="M599.8,240.0 L599.8,227.1 Q599.8,223.1 603.8,223.1 L619.8,223.1 Q623.8,223.1 623.8,227.1 L623.8,240.0 Z" fill="#eb6834"><title>Mask grounding · All: 0.04</title></path>
<text x="611.8" y="218.1" font-size="10.5" fill="#222" text-anchor="middle">0.04</text>
<text x="599.8" y="258" font-size="12" fill="#666" text-anchor="middle">All</text>
</svg></figure>
<p>Both box grounding and segmentation-mask grounding show significant improvement over no grounding at all. Although the images are still not sharp (likely due to the sparse data regime), the general shape is preserved and the target object does not disappear or glitch.</p>

<div style="display: grid; gap: 18px; margin: 16px 0 30px;">
  <figure style="margin: 0;"><video src="{{ site.baseurl }}/images/wm/ocb_block-single-task1.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video><figcaption style="font-size: 14px; color: #666;">block-single</figcaption></figure>
  <figure style="margin: 0;"><video src="{{ site.baseurl }}/images/wm/ocb_hanoi-single-task1.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video><figcaption style="font-size: 14px; color: #666;">hanoi-single</figcaption></figure>
  <figure style="margin: 0;"><video src="{{ site.baseurl }}/images/wm/ocb_block-double-task1.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video><figcaption style="font-size: 14px; color: #666;">block-double</figcaption></figure>
  <figure style="margin: 0;"><video src="{{ site.baseurl }}/images/wm/ocb_chamber-easy-task2.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video><figcaption style="font-size: 14px; color: #666;">chamber-easy</figcaption></figure>
</div>
<p style="font-size: 15px; color: #666;">Held-out OCBench episodes. Left to right: ground truth, box-grounded decoder, mask-grounded decoder.</p>

<h4>2.3 Predictor ablations <span style="font-size: 14px; font-weight: normal; color: #fff; background: #4CAF50; border-radius: 50px; padding: 2px 10px;">WIP</span></h4>

<p>Next: Flow-JEPA vs Dreamer on OCBench DINOv3 tokens (action-conditioned, current frame only, horizon 8), then a history × horizon sweep without actions. Models are training.</p>

<h3>3. Real robot data <span style="font-size: 14px; font-weight: normal; color: #fff; background: #4CAF50; border-radius: 50px; padding: 2px 10px; vertical-align: middle;">WIP</span></h3>


<h4>3.1 Decoder</h4>

<p>OCBench decoder recipe on real data: one decoder for all four datasets, frozen DINOv3-L head-camera tokens, object classes only (detector boxes are unreliable in cluttered real scenes). Also tested adding a reference frame (t−1, t−8, or the episode's first frame), borrowed from <a href="https://arxiv.org/abs/2605.15196" target="_blank">arXiv:2605.15196</a>.</p>
<table style="display: block; overflow-x: auto;">
  <tr><th>Decoder</th><th>PSNR</th><th>LPIPS</th><th>No objects (PSNR)</th><th>Wrong reference (PSNR)</th></tr>
  <tr><td>Classes only</td><td><strong>31.87</strong></td><td><strong>0.0390</strong></td><td>31.83</td><td></td></tr>
  <tr><td>+ reference t−1</td><td>31.70</td><td>0.0416</td><td>31.69</td><td>31.70</td></tr>
  <tr><td>+ reference t−8</td><td>31.71</td><td>0.0420</td><td>31.71</td><td>31.71</td></tr>
  <tr><td>+ first frame</td><td>31.70</td><td>0.0418</td><td>31.71</td><td>31.70</td></tr>
</table>
<p>The reference frame is essentially ignored. I will likely continue with either box or mask grounding.</p>

<div style="display: grid; gap: 18px; margin: 16px 0 10px;">
  <figure style="margin: 0;"><video src="{{ site.baseurl }}/images/wm/real_icl_demo_ep0.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video><figcaption style="font-size: 14px; color: #666;">Stack three cubes into a tower</figcaption></figure>
  <figure style="margin: 0;"><video src="{{ site.baseurl }}/images/wm/real_icl_ep7.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video><figcaption style="font-size: 14px; color: #666;">Assemble two gears</figcaption></figure>
  <figure style="margin: 0;"><video src="{{ site.baseurl }}/images/wm/real_oopsie.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video><figcaption style="font-size: 14px; color: #666;">Put the square on the peg</figcaption></figure>
  <figure style="margin: 0;"><video src="{{ site.baseurl }}/images/wm/real_sofia_ep6.mp4" autoplay loop muted playsinline style="width: 100%; height: auto;"></video><figcaption style="font-size: 14px; color: #666;">Pick up the red T and place it on the plate</figcaption></figure>
</div>
<p style="font-size: 15px; color: #666;">Held-out real episodes, head camera at 4 fps. Left to right: ground truth, classes only, + reference t−1, + reference t−8, + first frame.</p>

<h4>3.2 Next</h4>
<ul>
  <li>SAM 3 mask grounding instead of class labels, one dataset first.</li>
  <li>Action-conditioned Flow-JEPA and Dreamer predictors on real data, OCBench settings.</li>
  <li>Multi-camera (head + both wrists): per-view streams with cross-view attention vs one joint token sequence.</li>
</ul>
