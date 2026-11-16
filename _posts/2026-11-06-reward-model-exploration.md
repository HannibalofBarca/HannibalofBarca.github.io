---
layout: post
title: About Reward Models and Value Functions
---

<div class="rm-viewer" data-episode="0" data-models="robodopamine_zs,robodopamine_ft,robometer_zs,robometer_ft,topreward,gvl" data-visible="robodopamine_zs,robodopamine_ft,robometer_ft,topreward"></div>

<div class="rm-viewer" data-episode="1" data-models="icvfe,recap,robometer_ft_online,robometer_zs_online" data-visible="icvfe,recap,robometer_ft_online,robometer_zs_online"></div>

<p>In reinforcement learning a reward model is a mapping between the {S, A, S′} space, that is to say the space of all state-action transitions, and the corresponding rewards. The agent tries to collect as much reward as it can over time, so the reward is how the goal of a task is communicated to it. The sum of rewards from a time step to the end of an episode is known as the return R. The estimated sum of all future returns at a point is known as the Value of that state. In robotics, often reward models are used as progress estimators.</p>

<p>Almost every reward model uses a VLM in some capacity. What a reward model needs is visual reasoning: relating the task or goal to a video of it being done, and judging from the video whether the task is finished or how far along it is. The methods that come up most often:</p>
<ul>
  <li><a href="https://arxiv.org/abs/2411.04549" target="_blank">GVL</a>: shuffles the frames of an episode and asks a  agent to predict a completion percentage for each one, with no training. Shuffling stops the model from just reading progress off the frame order.</li>
  <li><a href="https://arxiv.org/abs/2605.08774" target="_blank">ProcVLM</a>: a fine-tuned VLM that first lists the subtasks still left to do, then outputs a completion percentage, so progress follows the steps of the procedure rather than elapsed time.</li>
  <li><a href="https://arxiv.org/abs/2306.00958" target="_blank">LIV</a>: learns a joint image-language embedding from videos with language annotations. The reward is how close the current frame's embedding is to the embedding of the goal, given as text or an image.</li>
  <li><a href="https://arxiv.org/abs/2603.02115" target="_blank">RoboMeter</a>: trained on frame-level progress labels from expert demos plus a preference loss that compares trajectories, so it also learns from failed and suboptimal runs.</li>
  <li><a href="https://arxiv.org/abs/2512.23703" target="_blank">Robo-Dopamine</a>: predicts the relative progress between two states from multiple camera views.</li>
</ul>

<h2>Ablations</h2>

<figure class="rm-fig" id="rm-radar-offline"></figure>
<figure class="rm-fig" id="rm-radar-online"></figure>

<p>Reward models differ in what they get to see. Some grade a completed episode, a full recording of the task being done once. Others grade how far along the task is while it is still being done. We call the first kind offline and the second online.</p>

<p class="rm-aside"><a href="https://ai4ce.github.io/VICTR/" target="_blank">VICTR</a> is an in-context VLA framework. It trains a demonstration-conditioned progress estimator and uses it to select relevant demonstration chunks for an adapted VLA. At deployment, the selected examples and the current execution state change while the trained parameters stay fixed. Comparing progress-based selection with visual retrieval tests whether an example is useful because it shows the right stage of the task, rather than just a similar image. In the paper and on this page we call RECAP and IC-VFE reward models, even though RECAP is a value function in the π*<sub>0.6</sub> paper and IC-VFE is a value function estimator. That is an abuse of nomenclature to an extent, but we were interested in the model architectures and how they behave as progress estimators. So we trained both on progress vs time, instead of RECAP's recipe, where the target is the return from step <i>t</i> to the end of the episode, Σ<sub><i>t</i>′=<i>t</i></sub><sup><i>T</i></sup> <i>r<sub>t′</sub></i>, with a reward of −1 per step and a large penalty on failure, normalized per task.</p>

<ul class="rm-list">
  <li class="off">Robo-Dopamine</li>
  <li class="off">RoboMeter</li>
  <li class="off">TOPReward</li>
  <li class="off">GVL</li>
  <li class="on">RoboMeter</li>
  <li class="on">RECAP</li>
  <li class="on">IC-VFE</li>
</ul>
<p class="rm-legend"><span class="off">■ offline</span><span class="on">■ online</span></p>

<p>TOPReward performs extremely well on the metrics, but on inspection it produces a monotonically increasing curve regardless of actual task progress.</p>

<h2>Results</h2>

<figure class="rm-fig" id="rm-bar-pearson"></figure>
<figure class="rm-fig" id="rm-bar-kendall"></figure>

<table class="rm-scroll">
  <tr><th>Model</th><th>Series</th><th>Pearson r</th><th>Kendall τ-b</th><th>MAE</th><th>Episodes</th></tr>
  <tr><td>Robo-Dopamine, zero-shot</td><td>offline</td><td>0.885</td><td>0.790</td><td>0.156</td><td>243</td></tr>
  <tr><td>TOPReward</td><td>offline</td><td>0.766</td><td>0.801</td><td>0.354</td><td>243</td></tr>
  <tr><td>Robo-Dopamine, fine-tuned</td><td>offline</td><td>0.797</td><td>0.716</td><td>0.135</td><td>231</td></tr>
  <tr><td>RoboMeter, fine-tuned</td><td>offline</td><td>0.795</td><td>0.667</td><td>0.200</td><td>231</td></tr>
  <tr><td>RoboMeter, zero-shot</td><td>offline</td><td>0.718</td><td>0.574</td><td>0.221</td><td>243</td></tr>
  <tr><td>GVL</td><td>offline</td><td>0.392</td><td>0.314</td><td>0.301</td><td>243</td></tr>
  <tr><td>IC-VFE</td><td>online</td><td>0.659</td><td>0.534</td><td>0.227</td><td>240</td></tr>
  <tr><td>RECAP</td><td>online</td><td>0.587</td><td>0.455</td><td>0.256</td><td>240</td></tr>
  <tr><td>RoboMeter online, fine-tuned</td><td>online</td><td>0.451</td><td>0.326</td><td>0.250</td><td>243</td></tr>
  <tr><td>RoboMeter online, zero-shot</td><td>online</td><td>0.363</td><td>0.265</td><td>0.263</td><td>243</td></tr>
</table>

<script>
(function () {
  var BASE = "{{ site.baseurl }}/images/rm/";
  var FONT = "Helvetica, Arial, sans-serif";
  // family colour; lighter tint (bars) and dashes (lines) mark the second variant
  var M = {
    robodopamine_zs: { name: "Robo-Dopamine ZS", lines: ["Robo-", "Dopamine", "ZS"], c: "#2a78d6" },
    robodopamine_ft: { name: "Robo-Dopamine FT", lines: ["Robo-", "Dopamine", "FT"], c: "#2a78d6", alt: true, tint: "#9fc3ec" },
    robometer_zs: { name: "RoboMeter ZS", lines: ["RoboMeter", "ZS"], c: "#eb6834" },
    robometer_ft: { name: "RoboMeter FT", lines: ["RoboMeter", "FT"], c: "#eb6834", alt: true, tint: "#f5b294" },
    topreward: { name: "TOPReward", lines: ["TOPReward"], c: "#1baf7a" },
    gvl: { name: "GVL", lines: ["GVL"], c: "#eda100" },
    robometer_zs_online: { name: "RoboMeter online ZS", lines: ["RoboMeter", "online", "ZS"], c: "#eb6834" },
    robometer_ft_online: { name: "RoboMeter online FT", lines: ["RoboMeter", "online", "FT"], c: "#eb6834", alt: true, tint: "#f5b294" },
    recap: { name: "RECAP", lines: ["RECAP"], c: "#e87ba4" },
    icvfe: { name: "IC-VFE", lines: ["IC-VFE"], c: "#6250d6" }
  };
  var fill = function (k) { return M[k].tint || M[k].c; };
  // ICVFE Evals analysis/output: */total_level_wide.csv (A1, A2, A3)
  var TOTAL = {
    robodopamine_zs: { r: 0.8855, tau: 0.7898 }, topreward: { r: 0.7655, tau: 0.8013 },
    robodopamine_ft: { r: 0.7967, tau: 0.7162 }, robometer_ft: { r: 0.7952, tau: 0.6675 },
    robometer_zs: { r: 0.7177, tau: 0.5741 }, gvl: { r: 0.3918, tau: 0.3142 },
    icvfe: { r: 0.6587, tau: 0.5335 }, recap: { r: 0.5874, tau: 0.4549 },
    robometer_ft_online: { r: 0.4509, tau: 0.3256 }, robometer_zs_online: { r: 0.3631, tau: 0.2650 }
  };
  // seen-unseen split/seen_unseen_split.csv, episode aggregation: [pearson, kendall, mae]
  var SPLIT = {
    robodopamine_zs: { seen: [0.8754, 0.7896, 0.1651], unseen: [0.8956, 0.7900, 0.1465] },
    robodopamine_ft: { seen: [0.7198, 0.6350, 0.1686], unseen: [0.8827, 0.8071, 0.0973] },
    robometer_zs: { seen: [0.7047, 0.5642, 0.2399], unseen: [0.7308, 0.5841, 0.2010] },
    robometer_ft: { seen: [0.7841, 0.6548, 0.2093], unseen: [0.8054, 0.6788, 0.1908] },
    topreward: { seen: [0.7377, 0.7975, 0.3705], unseen: [0.7936, 0.8051, 0.3377] },
    gvl: { seen: [0.4111, 0.3355, 0.3039], unseen: [0.3724, 0.2927, 0.2983] },
    robometer_zs_online: { seen: [0.3435, 0.2608, 0.2741], unseen: [0.3830, 0.2693, 0.2514] },
    robometer_ft_online: { seen: [0.4445, 0.3206, 0.2541], unseen: [0.4575, 0.3306, 0.2462] },
    recap: { seen: [0.6010, 0.4774, 0.2579], unseen: [0.5737, 0.4325, 0.2532] },
    icvfe: { seen: [0.6438, 0.5269, 0.2322], unseen: [0.6737, 0.5401, 0.2208] }
  };
  var NS = "http://www.w3.org/2000/svg";
  function el(tag, a, p, text) {
    var e = document.createElementNS(NS, tag);
    for (var k in a) e.setAttribute(k, a[k]);
    if (text != null) e.textContent = text;
    if (p) p.appendChild(e);
    return e;
  }
  function f2(v) { return v == null || isNaN(v) ? "–" : v.toFixed(2); }
  function mkSvg(parent, W, H, label) {
    var svg = el("svg", { viewBox: "0 0 " + W + " " + H, role: "img", "aria-label": label, "font-family": FONT, style: "width:100%;height:auto;display:block" }, parent);
    el("rect", { width: W, height: H, fill: "#fff" }, svg);
    return svg;
  }
  // legend in the site's chart style: short line swatch + label, wrapping; click toggles
  function legend(svg, keys, x0, y0, maxX, onToggle) {
    var x = x0, y = y0;
    keys.forEach(function (k) {
      var w = 28 + M[k].name.length * 6.6 + 20;
      if (x + w > maxX && x > x0) { x = x0; y += 20; }
      var g = el("g", { "class": "rm-lg", tabindex: 0, role: "button", "aria-label": "Toggle " + M[k].name }, svg);
      el("rect", { x: x - 2, y: y - 9, width: w - 14, height: 18, fill: "transparent" }, g);
      el("line", { x1: x, y1: y, x2: x + 22, y2: y, stroke: M[k].c, "stroke-width": 2, "stroke-dasharray": M[k].alt ? "6 4" : "none" }, g);
      el("text", { x: x + 28, y: y + 4, "font-size": 12, fill: "#222" }, g, M[k].name);
      var act = function () { g.classList.toggle("off", !onToggle(k)); };
      g.addEventListener("click", act);
      g.addEventListener("keydown", function (e) { if (e.key === "Enter" || e.key === " ") { e.preventDefault(); act(); } });
      x += w;
    });
    return y;
  }
  // ---------- radar: hexagon pointing left/right, seen tasks on the left, unseen on the right ----------
  var AXES = [
    ["Pearson r", "seen", 0, 240], ["Kendall τ-b", "seen", 1, 180], ["1 − MAE", "seen", 2, 120],
    ["Pearson r", "unseen", 0, 300], ["Kendall τ-b", "unseen", 1, 0], ["1 − MAE", "unseen", 2, 60]
  ];
  function axisVal(s, a) { return a[2] === 2 ? 1 - s[a[1]][2] : s[a[1]][a[2]]; }
  function radar(id, keys) {
    var W = 720, LBL = 82, R = (W - 2 * LBL) / 2 - 8;
    var host = document.getElementById(id);
    var shown = {}, groups = {};
    keys.forEach(function (k) { shown[k] = true; });
    // measure legend height first
    var probe = mkSvg(document.createElement("div"), W, 100, "");
    var ly = legend(probe, keys, 14, 14, W - 10, function () { return true; });
    var top = ly + 46, half = R * Math.sin(Math.PI / 3), H = Math.ceil(top + 2 * half + 30);
    var cx = W / 2, cy = top + half + 8;
    var svg = mkSvg(host, W, H, "Radar chart of Pearson r, Kendall tau-b and 1 - MAE on seen and unseen tasks");
    legend(svg, keys, 14, 14, W - 10, function (k) { shown[k] = !shown[k]; groups[k].style.display = shown[k] ? "" : "none"; return shown[k]; });
    function pt(deg, v) { return [cx + Math.cos(deg * Math.PI / 180) * R * v, cy + Math.sin(deg * Math.PI / 180) * R * v]; }
    el("text", { x: 14, y: top - 6, "font-size": 13, fill: "#222", "font-weight": "bold" }, svg, "Seen tasks");
    el("text", { x: W - 14, y: top - 6, "font-size": 13, fill: "#222", "font-weight": "bold", "text-anchor": "end" }, svg, "Unseen tasks");
    [0.25, 0.5, 0.75, 1].forEach(function (g) {
      el("polygon", { points: AXES.map(function (a) { return pt(a[3], g).join(","); }).join(" "), fill: "none", stroke: "#e6e6e6", "stroke-width": 1 }, svg);
      el("text", { x: cx + 4, y: cy - half * g + 12, "font-size": 10.5, fill: "#999" }, svg, String(g));
    });
    el("line", { x1: cx, y1: cy - half - 6, x2: cx, y2: cy + half + 6, stroke: "#ccc", "stroke-dasharray": "3 3" }, svg);
    AXES.forEach(function (a) {
      var p = pt(a[3], 1);
      el("line", { x1: cx, y1: cy, x2: p[0], y2: p[1], stroke: "#e6e6e6", "stroke-width": 1 }, svg);
      var q = pt(a[3], 1), right = a[1] === "unseen";
      el("text", { x: q[0] + (right ? 8 : -8), y: q[1] + 4 + (a[3] === 240 || a[3] === 300 ? -6 : a[3] === 120 || a[3] === 60 ? 8 : 0), "font-size": 12, fill: "#666", "text-anchor": right ? "start" : "end" }, svg, a[0]);
    });
    keys.forEach(function (k) {
      var g = el("g", {}, svg);
      var vals = AXES.map(function (a) { return axisVal(SPLIT[k], a); });
      var ring = AXES.map(function (a, i) { return { deg: a[3], v: vals[i] }; }).sort(function (p, q) { return p.deg - q.deg; });
      el("polygon", { points: ring.map(function (p) { return pt(p.deg, p.v).join(","); }).join(" "), fill: M[k].c, "fill-opacity": 0.05, stroke: M[k].c, "stroke-width": 2, "stroke-linejoin": "round", "stroke-dasharray": M[k].alt ? "6 4" : "none" }, g);
      AXES.forEach(function (a, i) {
        var p = pt(a[3], vals[i]);
        var c = el("circle", { cx: p[0], cy: p[1], r: 4, fill: M[k].c, stroke: "#fff", "stroke-width": 2 }, g);
        el("title", {}, c, M[k].name + " · " + a[0] + " (" + a[1] + "): " + vals[i].toFixed(3));
      });
      groups[k] = g;
    });
  }
  radar("rm-radar-offline", ["robodopamine_zs", "robodopamine_ft", "robometer_zs", "robometer_ft", "topreward", "gvl"]);
  radar("rm-radar-online", ["icvfe", "recap", "robometer_ft_online", "robometer_zs_online"]);
  // ---------- vertical bars ----------
  var OFF = ["robodopamine_zs", "topreward", "robodopamine_ft", "robometer_ft", "robometer_zs", "gvl"];
  var ON = ["icvfe", "recap", "robometer_ft_online", "robometer_zs_online"];
  function bars(id, title, metric) {
    var W = 720, H = 380, L = 44, Rr = W - 6, T = 44, B = 290;
    var svg = mkSvg(document.getElementById(id), W, H, title + " by model");
    el("text", { x: L, y: 22, "font-size": 12, fill: "#666" }, svg, title);
    function y(v) { return B - v * (B - T); }
    [0, 0.25, 0.5, 0.75, 1].forEach(function (t) {
      el("line", { x1: L, x2: Rr, y1: y(t), y2: y(t), stroke: "#e6e6e6", "stroke-width": 1 }, svg);
      el("text", { x: L - 8, y: y(t) + 4, "font-size": 11, fill: "#666", "text-anchor": "end" }, svg, String(t));
    });
    var slots = OFF.length + ON.length + 1, sw = (Rr - L) / slots, bw = Math.min(36, sw * 0.6), xs = {};
    OFF.forEach(function (k, i) { xs[k] = L + sw * (i + 0.5); });
    ON.forEach(function (k, i) { xs[k] = L + sw * (OFF.length + 1 + i + 0.5); });
    OFF.concat(ON).forEach(function (k) {
      var v = TOTAL[k][metric], cx = xs[k], x0 = cx - bw / 2, yt = y(v), r = 4;
      var p = el("path", { d: "M" + x0 + "," + B + " L" + x0 + "," + (yt + r) + " Q" + x0 + "," + yt + " " + (x0 + r) + "," + yt + " L" + (x0 + bw - r) + "," + yt + " Q" + (x0 + bw) + "," + yt + " " + (x0 + bw) + "," + (yt + r) + " L" + (x0 + bw) + "," + B + " Z", fill: fill(k) }, svg);
      el("title", {}, p, M[k].name + ": " + v.toFixed(3));
      el("text", { x: cx, y: yt - 5, "font-size": 10.5, fill: "#222", "text-anchor": "middle" }, svg, v.toFixed(2));
      var t = el("text", { x: cx, y: B + 16, "font-size": 10.5, fill: "#222", "text-anchor": "middle" }, svg);
      M[k].lines.forEach(function (ln, i) { el("tspan", { x: cx, dy: i === 0 ? 0 : 13 }, t, ln); });
    });
    function bracket(keys, label) {
      var x1 = xs[keys[0]] - bw / 2, x2 = xs[keys[keys.length - 1]] + bw / 2, yb = B + 62;
      el("path", { d: "M" + x1 + "," + (yb - 5) + " L" + x1 + "," + yb + " L" + x2 + "," + yb + " L" + x2 + "," + (yb - 5), fill: "none", stroke: "#ccc" }, svg);
      el("text", { x: (x1 + x2) / 2, y: yb + 16, "font-size": 12, fill: "#666", "text-anchor": "middle" }, svg, label);
    }
    bracket(OFF, "Offline");
    bracket(ON, "Online");
  }
  bars("rm-bar-pearson", "Pearson r", "r");
  bars("rm-bar-kendall", "Kendall τ-b", "tau");
  // ---------- episode viewers ----------
  var SMOOTH = { recap: 1, icvfe: 1, robometer_zs_online: 1, robometer_ft_online: 1 };
  function ema(a, k) { var o = [], p = null; a.forEach(function (v) { if (v != null) p = p == null ? v : k * v + (1 - k) * p; o.push(p); }); return o; }
  function viewer(root, ep, keys, visibleKeys, uid) {
    var visible = {};
    visibleKeys.forEach(function (k) { visible[k] = true; });
    var hasSmooth = keys.some(function (k) { return SMOOTH[k]; });
    root.innerHTML =
      '<video class="rm-video" muted playsinline preload="auto"></video>' +
      '<div class="rm-bar"><button type="button">Play</button><input type="range" min="0" step="0.01" value="0" aria-label="Seek"><span class="rm-time"></span></div>' +
      '<div class="rm-opts"><label for="' + uid + '-rate">Speed <select id="' + uid + '-rate"><option value="1">1×</option><option value="2" selected>2×</option><option value="4">4×</option></select></label>' +
      (hasSmooth ? '<label for="' + uid + '-smooth"><input type="checkbox" id="' + uid + '-smooth" checked> Smooth curves</label>' : "") + "</div>" +
      '<p class="rm-now"></p><div class="rm-chart"></div><div class="rm-models"></div>';
    var video = root.querySelector("video"), btn = root.querySelector(".rm-bar button"), scrub = root.querySelector("input[type=range]");
    var timeEl = root.querySelector(".rm-time"), rateSel = root.querySelector("select"), smoothCb = root.querySelector("#" + uid + "-smooth");
    var nowEl = root.querySelector(".rm-now"), box = root.querySelector(".rm-chart"), modelsBox = root.querySelector(".rm-models");
    var svg, playhead, hover, tip, W = 720, H = 320, scrubbing = false, drag = false;
    var PAD = { l: 44, r: 12, t: 30, b: 34 };
    function ser(k) { return smoothCb && smoothCb.checked && SMOOTH[k] ? ema(ep.series[k], 0.08) : ep.series[k]; }
    function xs(t) { return PAD.l + (t / ep.duration) * (W - PAD.l - PAD.r); }
    function ys(v) { return PAD.t + (1 - (v + 0.05) / 1.1) * (H - PAD.t - PAD.b); }
    function idxAt(t) { var n = ep.series.human.length; return Math.max(0, Math.min(n - 1, Math.round((t / ep.duration) * (n - 1)))); }
    function draw() {
      box.innerHTML = "";
      svg = mkSvg(box, W, H, "Progress over time");
      el("text", { x: PAD.l, y: 16, "font-size": 12, fill: "#666" }, svg, "Progress");
      [0, 0.25, 0.5, 0.75, 1].forEach(function (v) {
        el("line", { x1: PAD.l, x2: W - PAD.r, y1: ys(v), y2: ys(v), stroke: "#e6e6e6", "stroke-width": 1 }, svg);
        el("text", { x: PAD.l - 8, y: ys(v) + 4, "font-size": 11, fill: "#666", "text-anchor": "end" }, svg, String(v));
      });
      var step = ep.duration > 60 ? 15 : ep.duration > 25 ? 5 : 2;
      for (var t = 0; t <= ep.duration + 0.01; t += step) el("text", { x: xs(t), y: H - 16, "font-size": 11, fill: "#666", "text-anchor": "middle" }, svg, String(t));
      el("text", { x: (PAD.l + W - PAD.r) / 2, y: H - 2, "font-size": 12, fill: "#666", "text-anchor": "middle" }, svg, "Time (s)");
      ep.events.forEach(function (e) { if (e.t > 0.05) el("line", { x1: xs(e.t), x2: xs(e.t), y1: PAD.t, y2: H - PAD.b, stroke: "#eee", "stroke-dasharray": "2 3" }, svg); });
      var n = ep.series.human.length;
      function path(a) { var d = "", pen = false; a.forEach(function (v, i) { if (v == null) { pen = false; return; } d += (pen ? "L" : "M") + xs((i / (n - 1)) * ep.duration).toFixed(1) + "," + ys(v).toFixed(1); pen = true; }); return d; }
      keys.forEach(function (k) { if (visible[k]) el("path", { d: path(ser(k)), fill: "none", stroke: M[k].c, "stroke-width": 2, "stroke-linejoin": "round", "stroke-linecap": "round", "stroke-dasharray": M[k].alt ? "6 4" : "none" }, svg); });
      el("path", { d: path(ep.series.human), fill: "none", stroke: "#222", "stroke-width": 2.5, "stroke-linejoin": "round" }, svg);
      hover = el("line", { y1: PAD.t, y2: H - PAD.b, stroke: "#999", "stroke-width": 1, visibility: "hidden" }, svg);
      playhead = el("line", { y1: PAD.t, y2: H - PAD.b, stroke: "#4183C4", "stroke-width": 2 }, svg);
      tip = document.createElement("div"); tip.className = "rm-tip"; tip.hidden = true; box.appendChild(tip);
      sync();
    }
    function models() {
      modelsBox.innerHTML = '<label><span class="sw" style="color:#222;border-top-width:3px"></span>Human</label>';
      keys.forEach(function (k) {
        var m = ep.metrics[k], lab = document.createElement("label"), cb = document.createElement("input");
        cb.type = "checkbox"; cb.checked = !!visible[k]; cb.id = uid + "-m-" + k;
        cb.addEventListener("change", function () { visible[k] = cb.checked; draw(); });
        lab.htmlFor = cb.id; lab.appendChild(cb);
        lab.insertAdjacentHTML("beforeend", '<span class="sw' + (M[k].alt ? " dash" : "") + '" style="color:' + M[k].c + '"></span>' + M[k].name + ' <span class="tau">' + (m ? f2(m.kendall_tau_b) : "") + "</span>");
        modelsBox.appendChild(lab);
      });
    }
    function sync() {
      if (!playhead) return;
      var t = Math.min(video.currentTime || 0, ep.duration);
      playhead.setAttribute("x1", xs(t)); playhead.setAttribute("x2", xs(t));
      if (!scrubbing) scrub.value = t;
      timeEl.textContent = t.toFixed(1) + " / " + ep.duration.toFixed(1) + " s";
      var sub = "–";
      for (var i = 0; i < ep.events.length; i++) { if (ep.events[i].t <= t + 1e-3) sub = ep.events[i].name; else break; }
      nowEl.innerHTML = "Task: <b>" + ep.task + "</b> · current subtask: " + sub + " · human progress " + f2(ep.series.human[idxAt(t)]);
    }
    function seek(t) { video.currentTime = Math.max(0, Math.min(ep.duration, t)); sync(); }
    function tAtEvent(ev) { var r = svg.getBoundingClientRect(), x = ((ev.clientX - r.left) / r.width) * W; return Math.max(0, Math.min(ep.duration, ((x - PAD.l) / (W - PAD.l - PAD.r)) * ep.duration)); }
    box.addEventListener("pointerdown", function (ev) { drag = true; box.setPointerCapture(ev.pointerId); seek(tAtEvent(ev)); });
    box.addEventListener("pointerup", function () { drag = false; });
    box.addEventListener("pointermove", function (ev) {
      if (!svg) return;
      var t = tAtEvent(ev), i = idxAt(t);
      if (drag) seek(t);
      hover.setAttribute("x1", xs(t)); hover.setAttribute("x2", xs(t)); hover.setAttribute("visibility", "visible");
      tip.innerHTML = '<div class="r"><b>' + t.toFixed(1) + ' s</b></div><div class="r"><span>Human</span><span>' + f2(ep.series.human[i]) + "</span></div>" +
        keys.filter(function (k) { return visible[k]; }).map(function (k) { return '<div class="r"><span style="color:' + M[k].c + '">' + M[k].name + "</span><span>" + f2(ser(k)[i]) + "</span></div>"; }).join("");
      tip.hidden = false;
      var br = box.getBoundingClientRect(), left = ev.clientX - br.left + 14, top = ev.clientY - br.top - tip.offsetHeight - 10;
      if (left + tip.offsetWidth > box.clientWidth) left = ev.clientX - br.left - tip.offsetWidth - 14;
      if (top < 0) top = ev.clientY - br.top + 14;
      tip.style.left = Math.max(0, left) + "px"; tip.style.top = top + "px";
    });
    box.addEventListener("pointerleave", function () { if (tip) tip.hidden = true; if (hover) hover.setAttribute("visibility", "hidden"); });
    scrub.max = ep.duration;
    scrub.addEventListener("input", function () { scrubbing = true; seek(parseFloat(scrub.value)); });
    scrub.addEventListener("change", function () { scrubbing = false; });
    function toggle() { if (video.paused || video.ended) video.play().catch(function () {}); else video.pause(); }
    btn.addEventListener("click", toggle);
    video.addEventListener("click", toggle);
    video.addEventListener("play", function () { btn.textContent = "Pause"; });
    video.addEventListener("pause", function () { btn.textContent = video.ended ? "Replay" : "Play"; });
    video.addEventListener("loadedmetadata", function () { video.playbackRate = parseFloat(rateSel.value); });
    video.addEventListener("seeked", sync);
    video.addEventListener("timeupdate", function () { if (video.paused) sync(); });
    rateSel.addEventListener("change", function () { video.playbackRate = parseFloat(rateSel.value); });
    if (smoothCb) smoothCb.addEventListener("change", draw);
    (function loop() { if (!video.paused) sync(); requestAnimationFrame(loop); })();
    new ResizeObserver(function () { var w = box.clientWidth || 720, nw = Math.max(320, Math.round(w)); if (nw !== W) { W = nw; H = w < 520 ? 280 : 320; draw(); } }).observe(box);
    video.src = BASE + ep.video;
    W = Math.max(320, Math.round(box.clientWidth || 720));
    models();
    draw();
  }
  fetch(BASE + "episodes.json").then(function (r) { return r.json(); }).then(function (data) {
    document.querySelectorAll(".rm-viewer").forEach(function (root, n) {
      viewer(root, data[parseInt(root.dataset.episode, 10)], root.dataset.models.split(","), root.dataset.visible.split(","), "rm-v" + n);
    });
  });
})();
</script>
