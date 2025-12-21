---
title: "HuPrior3R: Incorporating Human Priors for Better 3D Dynamic
  Reconstruction from Monocular Videos"
authors: Weitao Xiong*, Zhiyuan Yuan*, Jiahao Lu, Chengfeng Zhao, Peng Li, Yuan Liu†
paper_link: https://www.arxiv.org/abs/2512.06368
published: 2025-12-21T01:24:00.000+08:00
image: /src/assets/images/human3r_teaser.jpg
tags:
  - 3D Reconstruction
  - arxiv
category: Research
draft: false
---
Monocular dynamic video reconstruction faces significant challenges in dynamic human scenes due to geometric inconsistencies and resolution degradation issues. Existing methods lack 3D human structural understanding, producing geometrically inconsistent results with distorted limb proportions and unnatural human-object fusion, while memory-constrained downsampling causes human boundary drift toward background geometry. To address these limitations, we propose to incorporate hybrid geometric priors that combine SMPL human body models with monocular depth estimation. Our approach leverages structured human priors to maintain surface consistency while capturing fine-grained geometric details in human regions. We introduce HuPrior3R, featuring a hierarchical pipeline with refinement components that processes full-resolution images for overall scene geometry, then applies strategic cropping and cross-attention fusion for human-specific detail enhancement. The method integrates SMPL priors through a Feature Fusion Module to ensure geometrically plausible reconstruction while preserving fine-grained human boundaries. Extensive experiments on TUM Dynamics and GTA-IM datasets demonstrate superior performance in dynamic human reconstruction.
