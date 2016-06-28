This repository contains data and source code used used in the publications [“Statistical geochemistry reveals disruption in secular lithospheric evolution about 2.5 Gyr ago”](http://www.nature.com/doifinder/10.1038/nature11024) and “Geochemical evolution of basalts preserved in the continental crust throughout Earth history” (under review) by Keller and Schoene.

CONTENTS:

[Igneous](igneous): This directory contains the full igneous whole-rock dataset and associated Monte-Carlo code, along with various plotting scripts.

[Resources](resources): Useful data and programs to accompany the whole-rock geochemical database. Includes alphaMELTS interface as well as code for finding properties such as crustal and lithospheric thickness, geologic province, etc., based on lat-lon coordinates. Data is derived from a variety of published sources, as cited in each subfolder.

[Functions](functions): This directory contains various short Matlab functions that are called by other Matlab programs in the repository as needed.


DEPENDENCIES:
1) MATLAB. A majority of the code in this repository is written in Matlab (denoted with extension .m). Some of this code may be compatible with GNU Octave as well, but this has not been tested.

2) alphaMELTS. Any code in this repository involving MELTS calculations requires a working installation of alphaMELTS. In particular the function [rmelts.m](resources/alphamelts/rmelts.m) (which provides the main interface between Matlab and alphaMELTS) must be able to find the alphamelts script run_alphamelts.command. By default it will look at /usr/local/bin/run_alphamelts.command, but this can be edited (on line 124) to point to another path if you do not want to install alphamelts in /usr/local/bin. While AlphaMELTS can be installed on Linux, Mac or Windows, the interface provided by rmelts.m assumes a *nix environment and would require modification to run on Windows. AlphaMELTS can be obtained from http://magmasource.caltech.edu/alphamelts/. 


INSTALLATION:
To use the included Matlab code, the entire repository should be added to your Matlab path. This can be done (among other ways) by right-clicking the folder containing this repository in Matlab and selecting “Add to Path” > “Selected Folders and Subfolders.” Individual functions and scripts can then be run from the Matlab editor, the command window, or from the command line.