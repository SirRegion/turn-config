# One of the supported executor types
#   see: https://docs.gitlab.com/runner/executors/
#   examples: shell, docker, kubernetes
EXECUTOR=docker

# The dns name of the host machine where the runner is installed
HOSTNAME=dev.mdctec.com

# A set of tags. Those values have to be used in your .gitlab-ci.yml configuration in order to use this runner.
TAGLIST=dev,docker

# The name of this runner. This will be visible e.g. in GitlabCI Frontend or the admin page
#   Pls follow the naming convention: <HOSTNAME>/<EXECUTOR> where
NAME="$HOSTNAME/$EXECUTOR"

# The default docker image in case you want to register a 'docker' executor
DOCKER_IMAGE=alpine:latest

sudo gitlab-runner register \
  --non-interactive \
  --run-untagged="false" \
  --locked="false" \
  --access-level="not_protected" \
  --name "$NAME" \
  --url "http://gitlab.mdctec.com/" \
  --registration-token "c586aRxqEUxsGKB3GUDy" \
  --executor "$EXECUTOR" \
  --tag-list "$TAGLIST" \
  --docker-image "$DOCKER_IMAGE"
