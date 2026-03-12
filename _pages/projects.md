---
layout: page
title: Projects
permalink: /projects/
---

<!-- <hr style="border: 0; border-top: 1px solid #eaeaea; margin: 30px 0;">

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  
  <img src="{{ site.baseurl }}/images/[IMAGE_FILENAME.jpg]" alt="[IMAGE_ALT_TEXT]" style="width: 200px; height: 150px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;" />
  <video src="{{ site.baseurl }}/images/[IMAGE_FILENAME.jpg]" [IMAGE_ALT_TEXT] autoplay loop muted playsinline style="width: 250px; height: 250px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;"></video>
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    [PROJECT_TITLE]
    <a href="[GITHUB_REPO_URL]" target="_blank" title="View on GitHub" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s;">
      <img src="{{ site.baseurl }}/images/GitHub_Invertocat_Black.svg" alt="GitHub Logo" style="width: 24px; height: 24px; border: none; box-shadow: none;" />
    </a>
  </h3>
  
  <p> Description</p>
  
</div> -->

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">

  <video src="{{ site.baseurl }}/images/RL_gait.mp4" alt="Unitree Go2 Locomotion" autoplay loop muted playsinline style="width: 250px; height: 250px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;"></video>
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    Unitree Go2 RL Policy for Locomotion
    <a href="https://github.com/HannibalofBarca/rob6323_go2_project" target="_blank" title="View on GitHub" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s;">
      <img src="{{ site.baseurl }}/images/GitHub_Invertocat_Black.svg" alt="GitHub Logo" style="width: 24px; height: 24px; border: none; box-shadow: none;" />
    </a>
  </h3>
  
  <p>A PPO-based RL controller for a Unitree Go2 robot dog in NVIDIA Isaac Sim that has custom rewards and the Raibert heuristic implemented for a stable, natural walking gait, and an actuator friction model implemented for increased simulation accuracy. The model was trained for plane, stepped, and rough terrains.</p>
</div>

<hr style="border: 0; border-top: 1px solid #eaeaea; margin: 30px 0;">

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  
  <video src="{{ site.baseurl }}/images/quadrotor.mp4" alt="Quadrotor Flip" autoplay loop muted playsinline style="width: 250px; height: 250px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;"></video>
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    2D Quadrotor MPC Controller
    <a href="https://github.com/HannibalofBarca/2D-Quadrotor-MPC" target="_blank" title="View on GitHub" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s;">
      <img src="{{ site.baseurl }}/images/GitHub_Invertocat_Black.svg" alt="GitHub Logo" style="width: 24px; height: 24px; border: none; box-shadow: none;" />
    </a>
  </h3>
  
  <p>SQP and MPC-based trajectory following controller for a 2D quadrotor. The controller was designed to execute a full loop maneuver. A simpler linear state position controller has also been <a href="https://github.com/HannibalofBarca/2D-Quadrotor-Linear-State-Feedback-Controller"> implemented</a></p>
  
</div>

<hr style="border: 0; border-top: 1px solid #eaeaea; margin: 30px 0;">

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  <img src="{{ site.baseurl }}/images/vpr_retrieval.png" alt="VPR Image Retrieval" style="width: 200px; height: 150px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;" />
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    Content-Based Image Retrieval for VPR
    <a href="https://github.com/HannibalofBarca/Visual-Place-Recognition-Image-Retrieval" target="_blank" title="View on GitHub" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s;">
      <img src="{{ site.baseurl }}/images/GitHub_Invertocat_Black.svg" alt="GitHub Logo" style="width: 24px; height: 24px; border: none; box-shadow: none;" />
    </a>
  </h3>
  
  <p>A Content-Based Image Retrieval system for Visual Place Recognition that has a ResNet-18 model implemented for generating semantic image embeddings, and a KD-Tree spatial indexing structure implemented for efficient nearest-neighbor lookups. The model was evaluated using the NYU-VPR dataset.</p>
</div>

<hr style="border: 0; border-top: 1px solid #eaeaea; margin: 30px 0;">

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  <video src="{{ site.baseurl }}/images/optical_flow.mp4" alt="Optical Flow Tracking" autoplay loop muted playsinline style="width: 250px; height: 250px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;"></video>
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    Lucas-Kanade Optical Flow
    <a href="https://github.com/HannibalofBarca/Optical-Flow" target="_blank" title="View on GitHub" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s;">
      <img src="{{ site.baseurl }}/images/GitHub_Invertocat_Black.svg" alt="GitHub Logo" style="width: 24px; height: 24px; border: none; box-shadow: none;" />
    </a>
  </h3>
  
  <p>A custom Lucas-Kanade optical flow algorithm for feature tracking.</p>
</div>

<hr style="border: 0; border-top: 1px solid #eaeaea; margin: 30px 0;">

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  <img src="{{ site.baseurl }}/images/ICP.png" alt="ICP_Kitti" style="width: 200px; height: 150px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;" />
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    ICP Point Cloud Registration
    <a href="https://github.com/HannibalofBarca/ICP-Point-Cloud-Registration" target="_blank" title="View on GitHub" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s;">
      <img src="{{ site.baseurl }}/images/GitHub_Invertocat_Black.svg" alt="GitHub Logo" style="width: 24px; height: 24px; border: none; box-shadow: none;" />
    </a>
  </h3>
  
  <p>A custom implementation of Iterative Closest Point (ICP) algorithm for point cloud registration for 3D mapping. The code was tested on the Kitti dataset</p>
</div>

<hr style="border: 0; border-top: 1px solid #eaeaea; margin: 30px 0;">

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  <video src="{{ site.baseurl }}/images/inverted_pendulum.mp4" alt="Inverted Pendulum Q-Learning" autoplay loop muted playsinline style="width: 250px; height: 250px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;"></video>
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    Inverted Pendulum Q-Learning Control
    <a href="https://github.com/HannibalofBarca/Inverted-Pendulum" target="_blank" title="View on GitHub" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s;">
      <img src="{{ site.baseurl }}/images/GitHub_Invertocat_Black.svg" alt="GitHub Logo" style="width: 24px; height: 24px; border: none; box-shadow: none;" />
    </a>
  </h3>
  
  <p>A Q-learning-based reinforcement learning controller for the inverted pendulum problem.</p>
</div>

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  <img src="{{ site.baseurl }}/images/april_tag.png" alt="April Tag" style="width: 200px; height: 150px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;" />
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    Camera Calibration and AprilTag AR
    <a href="https://github.com/HannibalofBarca/Camera-Calibration-and-April-Tag-AR" target="_blank" title="View on GitHub" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s;">
      <img src="{{ site.baseurl }}/images/GitHub_Invertocat_Black.svg" alt="GitHub Logo" style="width: 24px; height: 24px; border: none; box-shadow: none;" />
    </a>
  </h3>
  
  <p>AR camera calibration pipeline implemented for intrinsic estimation, and an AprilTag detection code implemented for pose tracking. The implementation was designed to render 3D geometric cubes onto physical tags in a scene.</p>
</div>

<hr style="border: 0; border-top: 1px solid #eaeaea; margin: 30px 0;">

<div style="margin-bottom: 40px; clear: both; overflow: hidden;">
  <video src="{{ site.baseurl }}/images/hexapod.mp4" alt="Hexapod Robot" autoplay loop muted playsinline style="width: 250px; height: 250px; object-fit: cover; border-radius: 8px; float: left; margin-right: 20px; margin-bottom: 10px; border: 1px solid #eaeaea;"></video>
  
  <h3 style="margin-top: 0; display: flex; align-items: center;">
    Hexapod Robot Design and Control
    <a href="https://github.com/HannibalofBarca/Hexapod" target="_blank" title="View on GitHub" style="margin-left: 10px; display: inline-flex; transition: opacity 0.2s;">
      <img src="{{ site.baseurl }}/images/GitHub_Invertocat_Black.svg" alt="GitHub Logo" style="width: 24px; height: 24px; border: none; box-shadow: none;" />
    </a>
  </h3>
  
  <p>A custom gesture-controlled hexapod robot that has an on-board microcontroller (several used over the length of the project including BS2, Arduino, RasPi etc...) and Wi-Fi telemetry implemented for custom gait algorithmss</p>
</div>