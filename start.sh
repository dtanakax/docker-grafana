#!/bin/bash
set -e

if [ "$1" = "/opt/grafana/bin/grafana-server" ]; then
  CONFIG=/opt/grafana/conf/defaults.ini

  FIRSTRUN=/firstrun
  if [ ! -f $FIRSTRUN ]; then
      sed -i -e "s|^data = data|data = /data|
                 s|^logs = data/log|logs = /data/log|
                 s/^mode = console, file/mode = console/
                 s/^admin_user = admin/admin_user = $ADMIN_USER/
                 s/^admin_password = admin/admin_password = $ADMIN_PASSWORD/
                 s/^allow_sign_up = true/allow_sign_up = $ALLOW_SIGN_UP/" $CONFIG
      touch $FIRSTRUN
  fi
  exec "$1" -homepath="/opt/grafana" -config="$CONFIG"
else
  exec "$@"
fi