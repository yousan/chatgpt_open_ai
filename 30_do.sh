#!/usr/bin/env bash
# 30_files.yaml を元にファイルごとに分割してリクエストを作成し、APIを呼び出す
# その際、30_base.md と 30_*.md を結合してリクエストを作成する。
# 成果物: src/30_*.md (他: tmp/30_request_*.json, tmp/30_response_*.json, tmp/30_response_body_*.md)
set -x

# リクエストプロンプトの基本となるファイルを生成
cat prompts/30_base_1.md  > prompts/30_base_2.md
echo '# 仕様書' >> prompts/30_base_2.md
cat prompts/20_shiyosho_prompt.md >> prompts/30_base_2.md
echo '# 今回の指示' >>  prompts/30_base_2.md

# 30_files.yaml を元にファイルごとに分割してリクエストを作成し、APIを呼び出す
num=$(yq '.files | length' prompts/30_files.yaml)
 for i in $(seq 0 $(($num-1))); do
     set +x
     filedetail=$(yq ".files[$i]" prompts/30_files.yaml)
     file=$(yq ".files[$i].file_slug" prompts/30_files.yaml) #管理用ファイル名に利用するslug
     detailedfile='prompts/30_'$file'_detailed.md'
     promptfile='prompts/30_'$file'.md'
     echo "${filedetail}" > $detailedfile

     cat prompts/30_base_2.md $detailedfile > $promptfile
     content=$(cat $promptfile)
     jq --arg content "${content}" '.messages[0].content = $content' request_template.json > tmp/30_request_${file}.json
     set -x
     curl https://api.openai.com/v1/chat/completions \
      -s \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer ${OPENAI_KEY}" \
      -d @tmp/30_request_${file}.json | tee tmp/30_response_${file}.json | jq -r '.choices[0].message.content' > tmp/30_response_body_${file}.md &
      set +x
done
wait;

set -x
# できあがったファイルをsrc/に移動
num=$(yq '.files | length' prompts/30_files.yaml)
for i in $(seq 0 $(($num-1))); do
  file=$(yq ".files[$i].file_slug" prompts/30_files.yaml) #管理用ファイル名に利用するslug
  codedown typescript < tmp/30_response_body_${file}.md > src/$(yq ".files[$i].filename" prompts/30_files.yaml)
done

