#!/bin/sh -l

set -e

SEARCH_PATH=$1
SEARCH_EXTENSIONS=$2
OUTPUT_FILE_PATCH=$3
ADD_GIT_INFO=$4

VALIDATION_COMMAND_JAR_PATH=config-validator.jar
AWS_ECR_REGION=us-east-1

mvn dependency:get -DremoteRepositories=http://nexus.olxbr.io/repository/maven-releases/ \
                   -DgroupId=com.olxbr \
                   -DartifactId=config-validator \
                   -Dclassifier=jar-with-dependencies \
                   -Dversion=LATEST \
                   -Dtransitive=false \
                   -Ddest=$VALIDATION_COMMAND_JAR_PATH

if [ $ADD_GIT_INFO = 'true' ]; then
    ADD_GIT_INFO='--check-git'
else
    unset ADD_GIT_INFO
fi

echo "java -jar $VALIDATION_COMMAND_JAR_PATH $SEARCH_PATH -e=$SEARCH_EXTENSIONS -o=$OUTPUT_FILE_PATCH $ADD_GIT_INFO"
java -jar $VALIDATION_COMMAND_JAR_PATH $SEARCH_PATH -e=$SEARCH_EXTENSIONS -o=$OUTPUT_FILE_PATCH $ADD_GIT_INFO

output_file=$OUTPUT_FILE_PATCH
echo "::set-output name=output_file::$output_file"