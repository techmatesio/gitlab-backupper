# Gitlab Repository Backupper

This script is used to clone all repositories from a GitLab instance.

## Usage

```shellscript
./backup.sh <gitlab_url> <api_key> <output_dir>
```

### Parameters

- `<gitlab_url>`: The URL of your GitLab instance.
- `<api_key>`: Your GitLab API key.
- `<output_dir>`: The directory where the repositories will be cloned.

## Description

The script first ensures that the output directory exists. It then retrieves a list of all project IDs from the GitLab instance using the provided API key.

For each project, it retrieves the repository details, including the SSH URL and the name of the repository. It then clones the repository into the output directory.

After cloning the repository, the script navigates into the repository directory and clones all branches.

## Requirements

- `curl`: Used to make HTTP requests to the GitLab API.
- `jq`: Used to parse JSON responses from the GitLab API.
- `git`: Used to clone repositories and branches.

## Note

This script clones repositories using SSH. Ensure that your SSH key is added to your GitLab account.
