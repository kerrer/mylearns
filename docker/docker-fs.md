ceph/daemon
==============





dfs
==================================
docker run  -d --name tracker  max/fastdfs tracker
docker run  -d --link tracker --name storage   max/fastdfs   storage
docker run  -it --link tracker --rm  max/fastdfs sh

docker run  -d --name tracker -v /work/data/fastdfs/tracker:/fdfsdfs/tracker/data   max/fastdfs  tracker
docker run  -d --name storage -v /work/data/fastdfs/storage/data:/fdfsdfs/data  -e TRACKER_SERVER=172.17.0.8:22122  max/fastdfs  storage



GlusterFS
===============
