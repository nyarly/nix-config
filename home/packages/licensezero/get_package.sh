#!/usr/bin/env bash

rev=eee1171e2f8a6e35c5599b39c12de9d8be2f7190
curl -O https://raw.githubusercontent.com/licensezero/cli/${rev}/package.json
curl -O https://raw.githubusercontent.com/licensezero/cli/${rev}/package-lock.json

jq '. + { name: "licensezerojs", version: "0" }' package.json > package.json.tmp && mv package.json.tmp package.json
