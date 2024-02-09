#!/usr/bin/env bash
set -x

file="20_shiyosho"

cat prompts/${file}_base.md prompts/$file.md > prompts/${file}_prompt.md

content=$(cat prompts/${file}_prompt.md)
jq --arg content "${content}" '.messages[0].content = $content' request_template.json > tmp/${file}_request.json

curl https://api.openai.com/v1/chat/completions \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${OPENAI_KEY}" \
 -d @tmp/${file}_request.json | tee tmp/${file}_response.json | jq -r '.choices[0].message.content' > tmp/${file}_output.md &

wait;

codedown yaml < tmp/${file}_output.md > prompts/30_files.yaml
