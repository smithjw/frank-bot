# AWS Login
# aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
# aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
# aws configure set default.region ap-southeast-2

# Build image
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
docker build -t smithjw/frank-bot:$BUILDKITE_COMMIT .

# Run container with specs
docker run -e HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN -d smithjw/frank-bot:$BUILDKITE_COMMIT

# Tag image with current branch name and push when specs are green
docker tag -f smithjw/frank-bot:$BUILDKITE_COMMIT smithjw/frank-bot:latest
docker push smithjw/frank-bot:latest

# Testing
