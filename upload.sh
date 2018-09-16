#!/usr/bin/env bash
set -eu -o pipefail

TMPFILE=$(mktemp)
function finish {
  rm -f $TMPFILE
}
trap finish EXIT

cd infra
printf "Grabbing TF output\n"
terraform output -json > $TMPFILE
cd - > /dev/null

distro_id=$(cat $TMPFILE | jq -r '.cloudfront_id.value')
bucket_name=$(cat $TMPFILE | jq -r '.bucket.value')

printf "Syncing to bucket %s\n" "${bucket_name}"
aws s3 sync ./site s3://apgelnar-hlhcasbm-site/

# printf "creating invalidation in distro id %s\n" "${distro_id}"
# aws cloudfront create-invalidation \
#   --distribution-id "${distro_id}" \
#   --paths /
