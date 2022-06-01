#!/bin/sh

set -e

if [[ -z $AWS_LAMBDA_RUNTIME_API ]]
then
    exec /bin/aws-lambda-rie /bin/demo-lambda-docker $@
else
    exec /bin/demo-lambda-docker $@
fi     
