#!/usr/bin/env bash

unraid_server='cosmia.techwi.red'

for app in traefik pihole unifi-controller grocy n8n tubesync http-https-echo Insync tekkit-minecraft-server ; do
	scp "root@${unraid_server}:/boot/config/plugins/dockerMan/templates-user/my-$app.xml" ./garrettheath4/"$app.xml"
done

#TODO: Scub tokens from templates, especially traefik, Insync, n8n, pihole
