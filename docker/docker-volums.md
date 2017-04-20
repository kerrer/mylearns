
local-persist -https://github.com/CWSpear/local-persist
=============================
curl https://github.com/CWSpear/local-persist/releases/download/v1.3.0/local-persist-linux-amd64 -o /usr/bin/docker-volume-local-persist
chmod +x /usr/bin/docker-volume-local-persist
docker volume create -d local-persist -o mountpoint=/job/cache/docker/images --name=images
curl https://raw.githubusercontent.com/CWSpear/local-persist/master/init/systemd.service -o /usr/bin/docker-volume-local-persist.service

sudo systemctl daemon-reload
sudo systemctl enable docker-volume-local-persist
sudo systemctl start docker-volume-local-persist


flocker:https://flocker-docs.clusterhq.com/en/latest/index.html
========================================================================


volumn:
========================================================================
docker create -v /dbdata --name data ubuntu:14.04 /bin/true
docker run -d --volumes-from dbdata --name db1 training/postgres
docker run --volumes-from data -v $(pwd):/backup ubuntu:14.04 tar cvf /backup/backup.tar /data

List:

$ docker volume ls -qf dangling=true
Cleanup:

$ docker volume rm $(docker volume ls -qf dangling=true)
Or, handling a no-op better but Linux specific:

$ docker volume ls -qf dangling=true | xargs -r docker volume rm

docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes --dry-run
docker run -v $(which docker):/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -v $(readlink -f /var/lib/docker):/var/lib/docker --rm martin/docker-cleanup-volumes --dry-run

volumn:
docker create -v /dbdata --name data ubuntu:14.04 /bin/true
docker run -d --volumes-from dbdata --name db1 training/postgres
docker run --volumes-from data -v $(pwd):/backup ubuntu:14.04 tar cvf /backup/backup.tar /data
