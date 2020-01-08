#!/bin/env sh
# reference: https://raw.githubusercontent.com/Quramy/graphql-script-sample/master/graphql_script.sh

DATA=$(curl -H "Authorization: token $GITHUB_TOKEN" -s -d @- https://api.github.com/graphql << GQL
{ "query": "
  query {
  viewer {
starredRepositories {
      totalCount
    }
    repositories(first: 3) {
      edges {
        node {
          name
          stargazers {
            totalCount
          }
          forks {
            totalCount
          }
          watchers {
            totalCount
          }
          issues(states:[OPEN]) {
            totalCount
          }
        }
      }
    }
    }
}" }
GQL
)

printf "%s\\n" "$DATA" 
# star3.sh EOF
