# Container image that runs your code
FROM public.ecr.aws/micahhausler/alpine:3.14.0

RUN apk --update add --no-cache git maven bash openjdk8-jre


#COPY entrypoint.sh /entrypoint.sh

# Volumes (Host/Container)
VOLUME ./ /

COPY ./* /

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]