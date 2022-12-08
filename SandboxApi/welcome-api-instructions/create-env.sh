#!/bin/bash 

echo "Starting sh"

export NEW_NS=$1

echo "\nGoing to apply this: \n\n"

envsubst < welcome-api.yaml 

echo "\n\n"

envsubst < welcome-api.yaml | kubectl apply -f - #-n $1

echo "\nYAML applied"