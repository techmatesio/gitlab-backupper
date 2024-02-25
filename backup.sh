#!/bin/bash

# Usage: ./clone_all_repos.sh <gitlab_url> <api_key> <output_dir>

GITLAB_URL=$1
API_KEY=$2
OUTPUT_DIR=$3

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Get the list of all project IDs
PROJECTS=$(curl --header "PRIVATE-TOKEN: $API_KEY" "$GITLAB_URL/api/v4/projects?per_page=100" | jq -r '.[].id')

for PROJECT_ID in $PROJECTS
do
  # Get repository details
  PROJECT=$(curl --header "PRIVATE-TOKEN: $API_KEY" "$GITLAB_URL/api/v4/projects/$PROJECT_ID")
  REPO_SSH_URL=$(echo $PROJECT | jq -r '.ssh_url_to_repo')
  NAME=$(echo $PROJECT | jq -r '.path_with_namespace')

  # Clone the repository using SSH
  git clone "$REPO_SSH_URL" "$OUTPUT_DIR/$NAME"

  # Clone all branches
  cd "$OUTPUT_DIR/$NAME"
  for BRANCH in $(git branch -a | grep remotes | grep -v HEAD | grep -v master); do
    git branch --track "${BRANCH#remotes/origin/}" "$BRANCH"
  done
  cd - > /dev/null
done