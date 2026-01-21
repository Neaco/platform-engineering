#! /bin/bash

set -Eeuo pipefail

l_domain_name=$1; shift
l_azDomainUrl="https://graph.microsoft.com/v1.0/domains"
l_verifUrl="$l_azDomainUrl/$l_domain_name/verify"


l_body=$(jq -n --arg id "$l_domain_name" '{id : $id}')

l_token_body=$(az account get-access-token --resource https://graph.microsoft.com)
l_token=$(echo $l_token_body | jq -r '.accessToken')




l_is_domain_verified=$(curl -sSL -X GET -H"Authorization: Bearer ${l_token}" -H "accept: application/json" -H "content-Type: application/json" $l_azDomainUrl -d "$l_body" \
    | jq -r --arg id "$l_domain_name" '.value[] | select(.id== $id).isVerified')

# Check whether the domain is already verified
if [ -z "$l_is_domain_verified" ]; then
    echo "ERROR: Domain not found">&2
    exit 1
elif [ "$l_is_domain_verified" ]; then
    exit 0
fi

# Try to verify the domain
l_verify=$(curl -L -X POST -H"Authorization: Bearer ${l_token}" -H "accept: application/json" -H "content-Type: application/json"  $l_verifUrl -d "{}" \
    jq -r ".isVerified")

if [ -z "$l_verify" ]; then
    echo "ERROR: Validation error">&2
    exit 1
elif [ "$l_verify" ]; then
    exit 0
else 
    echo "ERROR: Validation could not complete">&2
    exit 1
fi