# fio_test
当前目录包含以下功能脚本

** 1-run-cbs.sh  ##总的执行入口，其中设置numjobs和iodepth，默认包含(1,2,4,8,16,32)，需要其他参数可手动添加。

** 1-single-disk-cbs.sh  ##具体执行的脚本，其中设置了runtime、bs_size和rw方式

** result.py  ##使用python3执行，得出read/write/randread/randwrite四种方式的运行结果

** result-rw.py  ##使用python3执行，得出randrw/rw两种方式的运行结果
