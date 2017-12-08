#!/bin/sh

############################################################
## script to conduct defacing based on pydeface (https://github.com/poldracklab/pydeface)
## data structure should be organized based on BIDS (http://bids.neuroimaging.io/)
############################################################

## directory where date are located (BIDS)
path=/home/panda/ShareFolder/T
############################################################

cd ${path}

for file in $(ls)
do
cd ${path}/${file}/anat
pydeface.py *.gz
done
