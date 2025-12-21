---
title: "TrackingWorld: World-centric Monocular 3D Tracking of Almost All Pixels"
authors: Jiahao Lu, Weitao Xiong, Jiacheng Deng, Peng Li, Tianyu Huang, Zhiyang
  Dou, Cheng Lin, Sai-Kit Yeung, Yuan Liu†
paper_link: https://arxiv.org/abs/2512.08358
website: https://igl-hkust.github.io/TrackingWorld.github.io/
published: 2025-12-21T23:40:00.000+08:00
image: /src/assets/images/tracking_world_teaser.jpg
tags:
  - 3D Reconstruction
  - NeurIPS 2025
category: Research
draft: false
description: NeurIPS 2025 (Poster)
---
Monocular 3D tracking aims to capture the long-term motion of pixels in 3D space from a single monocular video and has witnessed rapid progress in recent years. However, we argue that the existing monocular 3D tracking methods still fall short in separating the camera motion from foreground dynamic motion and cannot densely track newly emerging dynamic subjects in the videos. To address these two limitations, we propose TrackingWorld, a novel pipeline for dense 3D tracking of almost all pixels within a world-centric 3D coordinate system. First, we introduce a tracking upsampler that efficiently lifts the arbitrary sparse 2D tracks into dense 2D tracks. Then, to generalize the current tracking methods to newly emerging objects, we apply the upsampler to all frames and reduce the redundancy of 2D tracks by eliminating the tracks in overlapped regions. Finally, we present an efficient optimization-based framework to back-project dense 2D tracks into world-centric 3D trajectories by estimating the camera poses and the 3D coordinates of these 2D tracks. Extensive evaluations on both synthetic and real-world datasets demonstrate that our system achieves accurate and dense 3D tracking in a world-centric coordinate frame.
