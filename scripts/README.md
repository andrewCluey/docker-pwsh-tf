
## EXAMPLE COMMANDS

### show tflint version inside container
docker run -v /Users/andy/Documents/GitHub/docker/scripts:/scripts cluey36/pwsh-tf tflint --version

### Run simple script and pass an environment variable
docker run -v /Users/andy/Documents/GitHub/docker-pwsh-tf/scripts:/scripts -e test=andy cluey36/pwsh-tf pwsh -command ./call.ps1




