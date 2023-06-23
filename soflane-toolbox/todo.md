Make a bash script as welcome and choices for user





docker run -ti -v ${PWD}/main.sh:/tools/main.sh -v ${PWD}/output:/output toolbox
docker run -ti -v ${PWD}/main.sh:/tools/main.sh -v ${PWD}/output:/output toolbox bash
docker run -ti --env-file .env -v ${PWD}/main.sh:/tools/main.sh -v ${PWD}/output:/output toolbox 