#!/usr/bin/env sh
apk --no-cache add curl
curl --silent --fail http://app:80 | grep 'PHP 7.4'
