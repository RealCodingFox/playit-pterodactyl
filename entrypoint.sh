#!/bin/bash
cd /home/container
# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"


pid=0

term_handler() {
  if [ "$pid" -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 0;
}

trap 'kill ${!}; term_handler' TERM

# Run the Server
${MODIFIED_STARTUP} &
pid="$!"

while :; do
    tail -f /dev/null & wait ${!}
done


