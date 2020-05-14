FROM ubuntu

WORKDIR "~/Desktop/SysAd DeltaInduct/Task-2/SubTask2"

RUN apt-get update && apt-get install -y locate
RUN apt-get install -y apt-utils
RUN apt-get install -y acl
RUN apt-get install -y cron


COPY . .

RUN chmod +x ./alias.sh
CMD ./alias.sh
# k
