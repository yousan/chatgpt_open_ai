#!/usr/bin/env bash
set -x


myArray=("main" "board" "othello" "player" "utils")

for file in ${myArray[@]}; do
  cat prompt_3_base.md prompt_3_${file}.md > tmp/prompt_4_${file}.md
  jq ".messages[0].content = \"$(cat tmp/prompt_4_${file}.md)\"" request_template.json > tmp/request_${file}.json
  curl https://api.openai.com/v1/chat/completions \
   -H "Content-Type: application/json" \
   -H "Authorization: Bearer ${OPENAI_KEY}" \
   -d @tmp/request_${file}.json | tee tmp/output_${file}.json | jq -r '.choices[0].message.content' > tmp/output_${file}.md &
   codedown python < tmp/output_${file}.md > src/main.py
done

wait;

exit;

jq ".messages[0].content = \"$(cat prompt_3_main.md)\"" request_template.json > request.json
curl https://api.openai.com/v1/chat/completions \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${OPENAI_KEY}" \
 -d @request.json | tee output.json | jq -r '.choices[0].message.content' > output.md
codedown python < output.md > src/main.py


jq ".messages[0].content = \"$(cat prompt_3_board.md)\"" request_template.json > request.json
curl https://api.openai.com/v1/chat/completions \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${OPENAI_KEY}" \
 -d @request.json | tee output.json | jq -r '.choices[0].message.content' > output.md
codedown python < output.md > src/board.py

jq ".messages[0].content = \"$(cat prompt_3_othello.md)\"" request_template.json > request.json
curl https://api.openai.com/v1/chat/completions \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${OPENAI_KEY}" \
 -d @request.json | tee output.json | jq -r '.choices[0].message.content' > output.md
codedown python < output.md > src/othello.py

jq ".messages[0].content = \"$(cat prompt_3_player.md)\"" request_template.json > request.json
curl https://api.openai.com/v1/chat/completions \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${OPENAI_KEY}" \
 -d @request.json | tee output.json | jq -r '.choices[0].message.content' > output.md
codedown python < output.md > src/player.py

jq ".messages[0].content = \"$(cat prompt_3_utils.md)\"" request_template.json > request.json
curl https://api.openai.com/v1/chat/completions \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${OPENAI_KEY}" \
 -d @request.json | tee output.json | jq -r '.choices[0].message.content' > output.md
codedown python < output.md > src/utils.py

