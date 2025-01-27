
#!/usr/bin/env bash

set -xeu

dir="${0%/*}"
cd $dir/..

token=$(cat _tools/secrets/fosshub_token.txt)
project_id='5f15fc217b2287584bc1e019'

tmpfile=$(mktemp)
curl https://data.authpass.app/data/artifact.download/.fosshub  | jq -c '. + {"publish": false, "isOldRelease": false}' >$tmpfile

cat $tmpfile | jq

curl -H "Content-Type: application/json" \
     -H "X-Auth-Key:${token}" \
     -d @${tmpfile} \
     -X POST https://api.fosshub.com/rest/projects/${project_id}/releases/

echo

rm ${tmpfile}
