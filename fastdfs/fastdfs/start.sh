#!/bin/bash
#set -e
# if the log file exists, delete it to avoid useless log content.
#for storage
STORAGE_LOG_FILE="$FASTDFS_STORAGE/logs/storaged.log"
NGINX_ERROR_LOG="/usr/local/nginx/logs/error.log"
STORAGE_PID_NUMBER="$FASTDFS_STORAGE/data/fdfs_storaged.pid"

# for tracker
TRACKER_LOG_FILE="$FASTDFS_TRACKER/logs/trackerd.log"
TRACKER_PID_NUMBER="$FASTDFS_TRACKER/data/fdfs_trackerd.pid"

TRACKER_SERVER="$TRACKER_PORT_22122_TCP_ADDR:$TRACKER_PORT_22122_TCP_PORT"


function start_storage {
	if [  -f "$STORAGE_LOG_FILE" ]; then 
	  rm  "$STORAGE_LOG_FILE"
    fi
    
    if [  -f "$STORAGE_PID_NUMBER" ]; then 
	  rm  "$STORAGE_PID_NUMBER"
    fi

if [  -f "$NGINX_ERROR_LOG" ]; then 
	rm  "$NGINX_ERROR_LOG"
fi

#create the soft link.

sed -i.bak -e "s|base_path=/home/yuqing/fastdfs|base_path=$FASTDFS_STORAGE|" \
        -e "s|store_path0=/home/yuqing/fastdfs|store_path0=$FASTDFS_STORAGE|"  \
        -e "s|tracker_server=127.0.0.1:22122|tracker_server=$TRACKER_SERVER|"  /etc/fdfs/storage.conf

sed -i.bak -e "s|tracker_server=tracker:22122|tracker_server=$TRACKER_SERVER|" \
        -e "s|store_path0=/home/yuqing/fastdfs|store_path0=$FASTDFS_STORAGE|"  /etc/fdfs/mod_fastdfs.conf
        

echo "start the storage node with nginx..."

# start the storage node.
fdfs_storaged /etc/fdfs/storage.conf start
DATA_SOURCE="$FASTDFS_STORAGE/data/"
DATA_SYNC="$FASTDFS_STORAGE/data/M00"

if [ -L ${DATA_SYNC} ] ; then
   rm $DATA_SYNC
fi

ln -s $DATA_SOURCE $DATA_SYNC

/usr/local/nginx/sbin/nginx

# wait for pid file(important!),the max start time is 5 seconds,if the pid number does not appear in 5 seconds,storage start failed.
TIMES=5
while [ ! -f "$STORAGE_PID_NUMBER" -a $TIMES -gt 0 ]
do
    sleep 1s
	TIMES=`expr $TIMES - 1`
done

# if the storage node start successfully, print the started time.
if [ $TIMES -gt 0 ]; then
    echo "the storage node started successfully at $(date +%Y-%m-%d_%H:%M)"
	
	# give the detail log address
    echo "please have a look at the log detail at $STORAGE_LOG_FILE and $NGINX_ERROR_LOG"

    # leave balnk lines to differ from next log.
    echo
    echo
	
	# make the container have foreground process(primary commond!)
    tail -F --pid=`cat $STORAGE_PID_NUMBER` /dev/null
# else print the error.
else
    echo "the storage node started failed at $(date +%Y-%m-%d_%H:%M)"
	echo "please have a look at the log detail at $STORAGE_LOG_FILE and $NGINX_ERROR_LOG"
	echo
    echo
fi
}


function start_tracker {
	if [ -f "$TRACKER_LOG_FILE" ]; then 
		rm "$TRACKER_LOG_FILE"
	fi
	if [ -f "$TRACKER_PID_NUMBER" ]; then 
		rm "$TRACKER_PID_NUMBER"
	fi

    sed -i.bak "s|base_path=/home/yuqing/fastdfs|base_path=$FASTDFS_TRACKER|" /etc/fdfs/tracker.conf
    
	echo "try to start the tracker node..."

	# start the tracker node.	
	fdfs_trackerd /etc/fdfs/tracker.conf start

# wait for pid file(important!),the max start time is 5 seconds,if the pid number does not appear in 5 seconds,tracker start failed.
TIMES=5
while [ ! -f "$TRACKER_PID_NUMBER" -a $TIMES -gt 0 ]
do
    sleep 1s
	TIMES=`expr $TIMES - 1`
done

# if the tracker node start successfully, print the started time.
if [ $TIMES -gt 0 ]; then
    echo "the tracker node started successfully at $(date +%Y-%m-%d_%H:%M)"
	
	# give the detail log address
	echo "please have a look at the log detail at $TRACKER_LOG_FILE"
	
	# leave balnk lines to differ from next log.
    echo
    echo
	
	# make the container have foreground process(primary commond!)
    tail -F --pid=`cat $TRACKER_PID_NUMBER` /dev/null
# else print the error.
else
    echo "the tracker node started failed at $(date +%Y-%m-%d_%H:%M)"
	
	# give the detail log address
	echo "please have a look at the log detail at $FASTDFS_LOG_FILE"
	
	# leave balnk lines to differ from next log.
    echo
    echo
fi

}

function start_client {
  sed -i.bak -e "s|base_path=/home/yuqing/fastdfs|base_path=${FASTDFS_CLIENT}|" \
       -e "s|tracker_server=127.0.0.1:22122|tracker_server=${TRACKER_SERVER}|"  /etc/fdfs/client.conf
  /bin/bash		
}
if [ "$1" == "storage" ]; then 
	start_storage
elif [ "$1" == "tracker" ]; then
    start_tracker
elif [ "$1" == "sh" ]; then
    start_client  
fi 
