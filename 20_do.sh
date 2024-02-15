#!/usr/bin/env bash
# 20_shiyosho_prompt.md を元にリクエストを作成し、APIを呼び出す
# 成果物: prompts/30_files.yaml (他: tmp/20_shiyosho_output.md, tmp/20_shiyosho_request.json, tmp/20_shiyosho_response.json)

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
