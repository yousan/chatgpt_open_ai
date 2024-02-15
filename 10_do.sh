#!/usr/bin/env bash
# 10_prompt.md を元にリクエストを作成し、APIを呼び出す
# 成果物: 20_shiyosho.md (他: tmp/10_prompt_output.md, tmp/10_prompt_request.json, tmp/10_prompt_response.json)
set -x

file="10_prompt"

jq ".messages[0].content = \"$(cat prompts/${file}.md)\"" request_template.json > tmp/${file}_request.json
curl https://api.openai.com/v1/chat/completions \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${OPENAI_KEY}" \
 -d @tmp/${file}_request.json | tee tmp/${file}_response.json | jq -r '.choices[0].message.content' > tmp/${file}_output.md &

wait;

cp tmp/${file}_output.md prompts/20_shiyosho.md
