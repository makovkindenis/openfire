
# openfire
Dockerized openfire

I built docker image with 
docker build -t makovkin/openfire .

then run it with

docker run --restart="always" --net="host" --name openfire -d makovkin/openfire
then copy logs directory outside from container
docker cp openfire:/opt/openfire/logs/ /opt/openfire/logs
and recreate container with
docker run --restart="always" --net="host" --name openfire -d -v /opt/openfire/logs/:/opt/openfire/logs/ makovkin/openfire
