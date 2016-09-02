1. 在http://code.google.com/p/fastdfs/downloads/list下载所需文件，此外还需先安装好libevent。
2. tar xzf FastDFS_v2.11.tar.gz
3. cd FastDFS
如果支持HTTP, vi make.sh，使用/WITH_HTTPD查找到这一行,输入i进入编辑模式,删除掉前面的注释#，:wq保存退出，如果需要安装成服务，则把下面一行也解开。
./make.sh
./make.sh install
4. 准备几个空闲的端口，可以使用netstat -an | grep 端口号是否被占用。
5. 根据实际情况修改/etc/fdfs下的配置文件，每个上面都有注释说明，如果需要HTTP，别忘了解开最下面的#include http.conf，要带一个#
6. 启动tracker: /usr/local/bin/fdfs_trackerd /etc/fdfs/tracker.conf
7. 启动storage: /usr/local/bin/fdfs_storaged /etc/fdfs/storage.conf，如果出现错误，可以到步骤5修改配置文件时设置的目录的log目录下查看具体错误原因。
8. 到此安装配置完毕


上传文件：/usr/local/bin/fdfs_upload_file  <config_file> <local_filename>
下载文件：/usr/local/bin/fdfs_download_file <config_file> <file_id> [local_filename]
删除文件：/usr/local/bin/fdfs_delete_file <config_file> <file_id>
monitor: /usr/local/bin/fdfs_monitor /etc/fdfs/client.conf


/usr/local/bin/stop.sh /usr/local/bin/fdfs_trackerd /etc/fdfs/tracker.conf
/usr/local/bin/stop.sh /usr/local/bin/fdfs_storaged /etc/fdfs/storage.conf
重启：
/usr/local/bin/restart.sh /usr/local/bin/fdfs_trackerd /etc/fdfs/tracker.conf
/usr/local/bin/restart.sh /usr/local/bin/fdfs_storaged /etc/fdfs/storage.con

./fdfs_test ../conf/client.conf upload QQ.png
/usr/bin/fdfs_test /etc/fdfs/client.conf download group1 M00/00/00/rBEAAlfFOnmAMTa9AAAAAyUW8X04144603_big

./fdfs_trackerd ../conf/tracker-1.conf
./fdfs_trackerd ../conf/tracker-2.conf
./fdfs_storaged ../conf/storage-g1-1.conf
./fdfs_storaged ../conf/storage-g2-1.conf
