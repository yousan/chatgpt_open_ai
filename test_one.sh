#!/usr/bin/env bash
set -x

file=main

cat prompt_3_base.md prompt_3_${file}.md > tmp/prompt_4_${file}.md
jq ".messages[0].content = \"$(cat tmp/prompt_4_${file}.md)\"" request_template.json > tmp/request_${file}.json
curl https://api.openai.com/v1/chat/completions \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${OPENAI_KEY}" \
 -d @tmp/request_${file}.json | tee tmp/output_${file}.json | jq -r '.choices[0].message.content' > tmp/output_${file}.md &
 codedown python < tmp/output_${file}.md > src/main.py
