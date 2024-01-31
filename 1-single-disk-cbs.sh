#!/bin/bash
set -x

#SHELL_FOLDER=$(dirname "$0")
#source ${SHELL_FOLDER}/common_variable_iscsi

IOENGINE="libaio"

FILE_NAME="/dev/cbd0"

RW=(randwrite randread write read)
BS=(4k 8k 16k 32k 64k 128k 1M)

NUMJOBS=$1   ##读取输入的第一个字符
DIRECT=1     ##跳过硬盘缓存
SIZE="960g"   ##一般为硬盘数量的整数倍
IODEPTH=$2    ##读取输入的第二个字符
RUNTIME=30    ##运行时间

for rw_name in ${RW[@]}
do
  for bs_size in ${BS[@]}
  do
    fio -ioengine=${IOENGINE} -numjobs=${NUMJOBS} -direct=${DIRECT}  -iodepth=${IODEPTH} -runtime=${RUNTIME} -size=${SIZE} -rw=${rw_name} -bs=${bs_size} -filename=${FILE_NAME} -name="iscsi_${IOENGINE}_${NUMJOBS}_${IODEPTH}_${rw_name}_${bs_size}" -group_reporting > iscsi_${IOENGINE}_${NUMJOBS}_${IODEPTH}_${rw_name}_${bs_size}.log
    sleep 1
  done
done

MIXRW=(randrw rw)
RWMIXREAD=70

for rw_name in ${MIXRW[@]}
do
  for bs_size in ${BS[@]}
  do
    fio -ioengine=${IOENGINE} -numjobs=${NUMJOBS} -direct=${DIRECT} -iodepth=${IODEPTH} -runtime=${RUNTIME} -size=${SIZE} -rw=${rw_name} -rwmixread=${RWMIXREAD} -bs=${bs_size} -filename=${FILE_NAME} -name="iscsi_${IOENGINE}_${NUMJOBS}_${IODEPTH}_${rw_name}_${RWMIXREAD}_${bs_size}" -group_reporting > iscsi_${IOENGINE}_${NUMJOBS}_${IODEPTH}_${rw_name}_${RWMIXREAD}_${bs_size}.log
    sleep 1
  done
done
