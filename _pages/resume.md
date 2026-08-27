---
layout: page
title: Resume
permalink: /resume/
---

<div class="resume-toggle-wrap">
  <span class="resume-toggle-label" id="resume-toggle-label-left">Resume</span>
  <button type="button" class="resume-toggle" id="resume-toggle" role="switch" aria-checked="false" aria-label="Toggle between Resume and CV">
    <span class="resume-toggle-knob"></span>
  </button>
  <span class="resume-toggle-label" id="resume-toggle-label-right">CV</span>
</div>

<iframe id="resume-frame" src="{{ site.baseurl }}/assets/Archit_Sharma_Resume.pdf" width="100%" height="800px" style="border: 1px solid #ccc; border-radius: 8px; margin-top: 20px;">
    <p>Your browser does not support viewing PDFs directly. <a id="resume-frame-fallback" href="{{ site.baseurl }}/assets/Archit_Sharma_Resume.pdf">Download the PDF</a> instead.</p>
</iframe>

<style>
  .resume-toggle-wrap {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-top: 20px;
  }

  .resume-toggle-label {
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    color: #666;
    font-size: 15px;
    transition: color 0.2s ease;
  }

  .resume-toggle-label.active {
    color: #222;
    font-weight: 600;
  }

  .resume-toggle {
    position: relative;
    width: 52px;
    height: 28px;
    border-radius: 999px;
    border: none;
    background: #eee;
    cursor: pointer;
    padding: 0;
    flex-shrink: 0;
    transition: background 0.25s ease;
  }

  .resume-toggle[aria-checked="true"] {
    background: #4183C4;
  }

  .resume-toggle-knob {
    position: absolute;
    top: 3px;
    left: 3px;
    width: 22px;
    height: 22px;
    border-radius: 50%;
    background: #fff;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
    transition: transform 0.25s ease;
  }

  .resume-toggle[aria-checked="true"] .resume-toggle-knob {
    transform: translateX(24px);
  }
</style>

<script>
  (function () {
    var toggle = document.getElementById('resume-toggle');
    var frame = document.getElementById('resume-frame');
    var fallbackLink = document.getElementById('resume-frame-fallback');
    var leftLabel = document.getElementById('resume-toggle-label-left');
    var rightLabel = document.getElementById('resume-toggle-label-right');
    var resumeSrc = '{{ site.baseurl }}/assets/Archit_Sharma_Resume.pdf';
    var cvSrc = '{{ site.baseurl }}/assets/Archit_Sharma_CV.pdf';

    leftLabel.classList.add('active');

    toggle.addEventListener('click', function () {
      var showingCV = toggle.getAttribute('aria-checked') === 'true';
      var next = !showingCV;
      toggle.setAttribute('aria-checked', next ? 'true' : 'false');

      var src = next ? cvSrc : resumeSrc;
      frame.setAttribute('src', src);
      if (fallbackLink) {
        fallbackLink.setAttribute('href', src);
      }

      leftLabel.classList.toggle('active', !next);
      rightLabel.classList.toggle('active', next);
    });
  })();
</script>
