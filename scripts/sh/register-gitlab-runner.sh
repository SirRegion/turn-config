
# One of the supported executor types
#   see: https://docs.gitlab.com/runner/executors/
#   examples: shell, docker, kubernetes
read -p "EXECUTOR:" GITLAB_RUNNER_EXECUTOR

# The name of this runner. This will be visible e.g. in GitlabCI Frontend on the admin page
#   Pls follow the naming convention: <HOSTNAME>/<EXECUTOR> where
GITLAB_RUNNER_NAME="$(cat /etc/hostname).mdctec.local/${GITLAB_RUNNER_EXECUTOR}"

## The default docker image in case you want to register a 'docker' executor
#DOCKER_IMAGE=alpine:latest

sudo gitlab-runner register \
  --run-untagged="false" \
  --locked="false" \
  --access-level="not_protected" \
  --name "$GITLAB_RUNNER_NAME" \
  --url "http://gitlab.mdctec.com/" \
  --registration-token "c586aRxqEUxsGKB3GUDy" \
  --executor "${GITLAB_RUNNER_EXECUTOR}"
