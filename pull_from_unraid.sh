#!/usr/bin/env bash

unraid_server='cosmianas.local'

scp "root@${unraid_server}:/boot/config/plugins/dockerMan/templates-user/my-Insync.xml" ./garrettheath4/Insync.xml
