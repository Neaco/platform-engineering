#! /bin/bash

set -Eeuo pipefail

l_domain_name=$1; shift
l_azDomainUrl="https://graph.microsoft.com/v1.0/domains"
l_verifUrl="https://graph.microsoft.com/v1.0/domains/$l_domain_name/verificationDnsRecords"

l_body=$(jq -n --arg id "$l_domain_name" '{id : $id}')

l_token_body=$(az account get-access-token --resource https://graph.microsoft.com)
l_token=$(echo $l_token_body | jq -r '.accessToken')

#l_create_response=$(curl -sSL -X DELETE -H"Authorization: Bearer ${l_token}" -H "accept: application/json" -H "content-Type: application/json" "$l_azDomainUrl/$l_domain_name" -d "$l_body")

l_create_response=$(curl -sSL -X POST -H"Authorization: Bearer ${l_token}" -H "accept: application/json" -H "content-Type: application/json" $l_azDomainUrl -d "$l_body")
l_create_return=$(echo $l_create_response | jq -r --arg domain "$l_domain_name" 'if .id == $domain then 0 elif .error and .error.details[0].code == "ObjectConflict" then 1 else .error.message end')

if [ "$l_create_return" -eq "1" ] || [ "$l_create_return" -eq "2" ]; then
    l_txt_record=$(curl -sSL -H"Authorization: Bearer ${l_token}" -H "accept: application/json"  $l_verifUrl | jq -r '.value[] | select(.recordType=="Txt") | {type: "TXT", name: .label, value: .text, ttl : .ttl |tostring}')
    if [ -z "$l_txt_record" ]; then
    echo "ERROR: no TXT record found" >&2
    exit 1
    fi
    echo $l_txt_record
else
    echo "$l_create_return" >&2
    exit 1
fi
