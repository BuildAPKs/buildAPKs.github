#!/bin/env sh
# reference: https://raw.githubusercontent.com/Quramy/graphql-script-sample/master/graphql_script.sh

DATA=$(curl -H "Authorization: token $GITHUB_TOKEN" -s -d @- https://api.github.com/graphql << GQL
{ "query": "
  repository(name: "shlibs.sh" owner: "shlibs")
" }
GQL
)

printf "%s\\n" "$DATA" 
# printf "%s\\n" "$DATA" | jq -r .data.viewer.bio
# bio.sh ZEOF
