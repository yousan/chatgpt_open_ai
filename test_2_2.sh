#!/usr/bin/env bash

# ファイルに分割してループを回す
num=$(yq '.files | length' files.yaml)
 for i in $(seq 0 $(($num-1))); do
     filedetail=$(yq ".files[$i]" files.yaml)
     file=$(yq ".files[$i].file_slug" files.yaml) #管理用ファイル名に利用するslug
     echo "${filedetail}" > prompt_3_${file}.md

     cat prompt_3_base.md prompt_3_${file}.md > tmp/prompt_4_${file}.md
     content=$(cat tmp/prompt_4_${file}.md)
     jq --arg content "${content}" '.messages[0].content = $content' request_template.json > tmp/request_${file}.json
     curl https://api.openai.com/v1/chat/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer ${OPENAI_KEY}" \
      -d @tmp/request_${file}.json | tee tmp/output_${file}.json | jq -r '.choices[0].message.content' > tmp/output_${file}.md &
done

wait;


for i in $(seq 0 $(($num-1))); do
  file=$(yq ".files[$i].file_slug" files.yaml) #管理用ファイル名に利用するslug
  codedown python < tmp/output_${file}.md > src/${file}.py
done    