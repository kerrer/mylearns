#!/bin/bash
#
#@daily /path/to/yourmysql.sh
#

MYUSER="yxqlc"
MYPASS="pK*2\$sVs2Usy2sZs"
MYHOST="127.0.0.1"

MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
CHOWN="$(which chown)"
CHMOD="$(which chmod)"
GZIP="$(which gzip)"

DEST="/backup"
MBD="$DEST/mysql"
HOST="$(hostname)"

NOW="$(date +"%Y-%m-%d")"

FILE=""
DBS=""
IGGY="test"
DUMPDBS=( h_alipay  h_wechat yxw yxw_hospital )

[ ! -d $MBD ] && mkdir -p $MBD || :

$CHOWN 0.0 -R $DEST
$CHMOD 0600 $DEST


for db in "${DUMPDBS[@]}"
do
        FILE="$MBD/$db.$HOST.$NOW.gz"
        $MYSQLDUMP --skip-lock-tables  --user=$MYUSER  --host=$MYHOST --password=$MYPASS $db | $GZIP -9 > $FILE
done

find $MBD -type f -mtime +15 -exec rm -f {} \;
