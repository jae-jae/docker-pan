#!/bin/bash
set -eux

if [ ! -e /var/www/html/index.php ];  then
        echo "[FileRun fresh install]"
        unzip /filerun.zip -d /var/www/html/
        cp /autoconfig.php /var/www/html/system/data/
        mkdir -p /user-files/superuser/dl
        wget https://gist.githubusercontent.com/jae-jae/9b09a9bf90b733aed896713f56c8a1f2/raw/install-aria2-ui.sh 
        bash install-aria2-ui.sh
        # rm -R /var/www/html/dl/files
        # ln -s /user-files/superuser/dl /var/www/html/dl/files
        chown -R www-data:www-data /var/www/html
        chown -R www-data:www-data /user-files
        /wait-for-it.sh db:3306 -t 120 -- /import-db.sh

fi

exec "$@"