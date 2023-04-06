#!/bin/bash

dir=$(pwd)
crt_file=$(cat "$dir"/crt_file.crt)
key_file=$(cat "$dir"/key_file.key)
list_domain=$(cat "$dir"/list_domain.txt | awk {'print $1'} | sed -e "s/://g")
crt=$(printf %s "$crt_file" | jq -sRr @uri)
key=$(printf %s "$key_file" | jq -sRr @uri)

while read -r domain; do
    whmapi1 --output=jsonpretty \
        installssl \
        domain=''$domain'' \
        crt="$crt" \
        key="$key"
done <<<"$list_domain"
