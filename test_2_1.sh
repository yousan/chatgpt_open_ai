#!/usr/bin/env bash
set -x

file="2_1"

jq ".messages[0].content = \"$(cat prompt_2_1.md)\"" request_template.json > tmp/request_2_1.json
curl https://api.openai.com/v1/chat/completions \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${OPENAI_KEY}" \
 -d @tmp/request_${file}.json | tee tmp/output_${file}.json | jq -r '.choices[0].message.content' > tmp/output_${file}.md &

wait;
