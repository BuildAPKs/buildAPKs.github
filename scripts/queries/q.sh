#!/bin/env sh
# reference: https://raw.githubusercontent.com/Quramy/graphql-script-sample/master/graphql_script.sh

DATA=$(curl -H "Authorization: token $GITHUB_TOKEN" -s -d @- https://api.github.com/graphql << GQL
 { 
   "query": "$(cat QUERY)" 
 } 
GQL
)

printf "%s\\n" "$DATA"
# q.sh
