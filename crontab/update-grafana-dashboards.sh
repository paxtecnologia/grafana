#!/bin/bash

cd ~/git/grafana || exit 1
git pull --quiet

LOCAL_FILE="provisioning/dashboards/dashboardproviders.yaml"
TARGET_FILE="/etc/grafana/provisioning/dashboards/dashboardproviders.yaml"

SRC_DIR="./dashboards"
DEST_DIR="/etc/grafana/dashboards"

if ! cmp -s "$LOCAL_FILE" "$TARGET_FILE" || ! diff -qr "$SRC_DIR" "$DEST_DIR" > /dev/null; then
    cp "$LOCAL_FILE" "$TARGET_FILE"
    rsync -aq --delete "$SRC_DIR/" "$DEST_DIR/"
    chown -R grafana:grafana /etc/grafana
    systemctl restart grafana-server
fi
