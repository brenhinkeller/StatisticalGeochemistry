#!/bin/bash
#Commands for extracting data from Crust 1.0 model

# find the Crust 2.0 data for each lat, lon pair in 'query', pipe to getCN2point command, 
# (results stored in outcr), redirect screen output to file 'outlog'.

cat coordinates | ./getCN1point > layers.out

# grep the output file for average, upper, middle, and lower crustal data (there is also 
# data for sediment, ice and water). 
# Output format: vp vs rho bottom

grep "topography" layers.out | sed 's/ topography://' > topography.out
awk 'c&&!--c;/layers: vp,vs,rho,bottom/{c=6}' layers.out > uppercrust.out
awk 'c&&!--c;/layers: vp,vs,rho,bottom/{c=7}' layers.out > middlecrust.out
awk 'c&&!--c;/layers: vp,vs,rho,bottom/{c=8}' layers.out > lowercrust.out

