build:
  FROM bitnami/minideb
  USER 0
  RUN install_packages mariadb-client && \
  useradd -ms /bin/bash -u 1001 dbmanager && mkdir /var/dbManager
  COPY CLI/. /var/dbManager
  RUN install -o root -g root -m 0755 /var/dbManager/dbManager /usr/local/bin/dbManager && rm -rf /var/dbManager/dbManager && \
    chown -R 1001:1001 /var/dbManager && chmod +x -R /var/dbManager
  USER dbmanager
  SAVE IMAGE --push heiran/dbmanager
