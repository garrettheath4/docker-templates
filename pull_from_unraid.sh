#!/usr/bin/env bash

unraid_server='cosmia.gh4.red'

# Templates to skip when pulling from the server (basename, without my- prefix)
skip=(
	BarcodeBuddy
	binhex-minecraftserver
	boinc
	tekkit-classic-docker
	tekkit-classic-minecraft
	tekkit-minecraft-server
	ts-dnsserver
)

# Pull all user templates from the unRAID server, stripping the my- prefix.
# Matches by basename so templates in subdirectories (e.g. autostart) are skipped;
# templates already present locally aren't removed — that's handled separately.
cd "$(dirname "$0")" || exit 1
echo 'Downloading Docker templates from Cosmia...' 1>&2
pulling_printed=0
for remote in $(ssh "root@${unraid_server}" 'printf "%s\n" /boot/config/plugins/dockerMan/templates-user/my-*.xml'); do
	base=$(basename "$remote" .xml)
	app=${base#my-}
	skip_it=0
	for s in "${skip[@]}"; do
		if [[ "$app" == "$s" ]]; then
			skip_it=1
			break
		fi
	done
	if (( skip_it )); then
		continue
	fi
	if [ "$pulling_printed" = 0 ]; then
		echo -n 'Pulling: '
		pulling_printed=1
	fi
	echo -n "$app "
	scp -q "root@${unraid_server}:${remote}" "./garrettheath4/${app}.xml"
done
echo # newline

# Redact sensitive values from all freshly pulled templates
echo 'Redacting sensitive values (passwords) from templates...' 1>&2
for f in garrettheath4/*.xml ; do
	xsltproc redact.xsl "$f" | sed -e 's|<Value/>|<Value></Value>|g' -e 's|&#13;|\&#xD;|g' > tmpfile && mv tmpfile "$f"
done

# Sanity check: fail if any masked config still has non-empty contents,
# or if any Default attribute still contains an email address
echo 'Verifying no sensitive values exist anymore...' 1>&2
leaks=0
for f in garrettheath4/*.xml ; do
	if result=$(xmllint --xpath '//Config[@Mask="true"][text()]' "$f" 2>/dev/null) && [[ -n "$result" ]] ; then
		echo "ERROR: masked value survived redaction in $f:" >&2
		echo "$result" >&2
		leaks=1
	fi
	if result=$(xmllint --xpath '//Config/@Default[contains(.,"@")][not(contains(.,"["))][not(contains(.,"example@"))]' "$f" 2>/dev/null) && [[ -n "$result" ]] ; then
		echo "ERROR: email address survived in a Default attribute in $f:" >&2
		echo "$result" >&2
		leaks=1
	fi
done
(( leaks )) && exit 1
echo 'All templates redacted cleanly.'
