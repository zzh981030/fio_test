#!/bin/bash

NUMJOBS=(1 2 4 8 16 32)
IODEPTH=(1 2 4 8 16 32)

for iodepth in ${NUMJOBS[@]}
  do
    for numjobs in  ${IODEPTH[@]}
      do
        ./1-single-disk-cbs.sh ${numjobs} ${iodepth}
     done
done
