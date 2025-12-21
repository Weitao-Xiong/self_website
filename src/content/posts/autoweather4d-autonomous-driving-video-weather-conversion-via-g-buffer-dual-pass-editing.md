---
title: "AutoWeather4D: Autonomous Driving Video Weather Conversion via G-Buffer
  Dual-Pass Editing"
authors: Tianyu Liu*, Weitao Xiong*, Kunming Luo, Manyuan Zhang, Peng Li, Yuan
  Liu, Ping Tan
published: 2025-12-22T00:57:00.000+08:00
image: /src/assets/images/autoweather4d_teaser.jpg
tags:
  - Inverse Rendering
  - Video Generation
  - under review
category: Under Review
draft: false
description: ""
---
Weather and time-of-day variations are critical for robust autonomous driving testing, yet acquiring diverse, high-fidelity real-world data—especially paired data of the same scene under different conditions—remains costly, time-consuming, and logistically constrained. With recent advancements in feed-forward 4D reconstruction and real-scene inverse rendering, integrating these advances with classical computer graphics has become feasible, prompting us to propose AutoWeather4D: a modular synthetic data generation framework without requiring additional fine-tuning data. It features a G-Buffer dual-pass editing mechanism: Geometry Pass interacts between weather elements (e.g., rain, snow) and scene geometry, while Light Pass adjusts illumination for natural time-of-day transitions and weather-induced lighting changes. Experiments demonstrate that AutoWeather4D outperforms state-of-the-art baselines in physical realism (avoiding "impossible videos") and fine-grained controllability over both weather and time-of-day. This work serves as a reliable supplement to real-world data, enabling robust testing of autonomous driving systems under complex environmental conditions.
