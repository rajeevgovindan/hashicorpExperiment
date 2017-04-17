#!/bin/sh

redis_status=`redis-cli ping`;
if [ "$redis_status" = "PONG" ]; then
   echo "Got Pong.";
   exit 0;
else
   echo "Did not get Pong.";
   exit -1;
fi

