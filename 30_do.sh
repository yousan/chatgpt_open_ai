#!/usr/bin/env bash

set -x

# ファイルに分割してループを回す
num=$(yq '.files | length' prompts/30_files.yaml)
 for i in $(seq 0 $(($num-1))); do
     filedetail=$(yq ".files[$i]" prompts/30_files.yaml)
     file=$(yq ".files[$i].file_slug" prompts/30_files.yaml) #管理用ファイル名に利用するslug
     detailedfile='prompts/30_'$file'_detailed.md'
     promptfile='prompts/30_'$file'.md'
     echo "${filedetail}" > $detailedfile


     cat prompts/30_base.md $detailedfile > $promptfile
     content=$(cat $promptfile)
     jq --arg content "${content}" '.messages[0].content = $content' request_template.json > tmp/30_request_${file}.json
     curl https://api.openai.com/v1/chat/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer ${OPENAI_KEY}" \
      -d @tmp/30_request_${file}.json | tee tmp/30_response_${file}.json | jq -r '.choices[0].message.content' > tmp/30_response_body_${file}.md &
done

wait;

num=$(yq '.files | length' prompts/30_files.yaml)
for i in $(seq 0 $(($num-1))); do
  file=$(yq ".files[$i].file_slug" prompts/30_files.yaml) #管理用ファイル名に利用するslug
  codedown javascript < tmp/30_response_body_${file}.md > src/$(yq ".files[$i].filename" prompts/30_files.yaml)
done
