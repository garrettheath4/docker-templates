#!/usr/bin/env bash

unraid_server='cosmia.local'

scp "root@${unraid_server}:/boot/config/plugins/dockerMan/templates-user/my-Insync.xml" ./garrettheath4/Insync.xml
scp "root@${unraid_server}:/boot/config/plugins/dockerMan/templates-user/my-tekkit-minecraft-server.xml" ./garrettheath4/tekkit-minecraft-server.xml
