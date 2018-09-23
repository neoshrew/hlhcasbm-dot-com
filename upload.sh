#!/usr/bin/env bash
set -eu -o pipefail

TMPFILE=$(mktemp)
function finish {
  rm -f $TMPFILE
}
trap finish EXIT

now=$(date +%Y-%m-%dT%H:%M:%S%z)
printf "Setting nuptuals to now - %s\n" "${now}"
# Note to future generations - this isn't ideal
regex="^(\s*const marriedAt = new Date\(').*?('\);)"
repl="\1${now}\2"
sed -Ei "s/${regex}/${repl}/" site/index.html

cd infra
printf "Grabbing TF output\n"
terraform output -json > $TMPFILE
cd - > /dev/null

distro_id=$(cat $TMPFILE | jq -r '.cloudfront_id.value')
bucket_name=$(cat $TMPFILE | jq -r '.bucket.value')

printf "Syncing to bucket %s\n" "${bucket_name}"
aws s3 sync ./site s3://"${bucket_name}/"

printf "creating invalidation in distro id %s\n" "${distro_id}"
aws cloudfront create-invalidation \
  --distribution-id "${distro_id}" \
  --paths /
