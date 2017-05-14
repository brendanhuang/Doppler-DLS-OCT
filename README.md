# Doppler-DLS-OCT
A short Matlab-based tutorial on performing Doppler and Dynamic Light Scattering processing on Optical Coherence Tomography. The tutorial aims to give basic physical intuition to the measurements. Also useful for ultrasound signal processing.

<img src="/images/dls.png" width = "80%" align="middle">

Optical coherence tomography (OCT) is a non-invasive, microscopic medical imaging technique that can give information about microfluidic flow, including blood and mucociliary flow [1]. In particular, OCT can make use of the Doppler effect, a shift in the frequency of returning light, in order to estimate flow along the direction of light propagation. Dynamic light scattering (DLS) is a signal processing technique that has been proposed to be used to recover the dynamics of flow in all three-dimensions [2,3].

This tutorial gives a short overview of basic OCT signal processing. In it, you will learn what type of information we recover in an OCT measurement, and how we can process that measurement over time to get an estimate of fluid flow velocity. Additionally, OCT is often considered the light-analogue of ultrasound.  All of the signal processing machinery presented here can equally be applied towards ultrasound signals as well.

# Installation

1. Download all files.
2. Change the current directory to the "files" folder or add to the Matlab path.
3. Execute dlsscript.m cell by cell.
4. Follow along with the tutorial.

# How to use this repository
This repository contains several types of files, including:
1. A narrated tutorial document (dlstutorial.pdf)
2. A Matlab m-file that can be executed
3. Raw OCT data that can be called as a .mat file
4. Some supporting images

The goal of the repository is to introduce interested users to processing OCT data, with a specific emphasis on velocimetry data.

# References 

[1] Huang, BK and MA Choma. "Microscale imaging of cilia-driven fluid flow." Cell. and Mol. Life Sci. (epub 2014)

[2] Huang, BK and MA Choma. "Resolving directional ambiguity in dynamic light scattering-based transverse motion velocimetry in optical coherence tomography." Opt. Lett. 39, 3 (2014)

[3] Huang, BK, UA Gamm, V Bhandari, MK Khokha, and MA Choma, "Three-dimensional, three-vector-component velocimetry of cilia-driven fluid flow using correlation-based approaches in optical coherence tomography." Biomed. Opt. Exp. 6, 9 (2015)
