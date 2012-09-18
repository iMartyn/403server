#!/bin/bash

while [ $? -eq 0 ]; do 
  rm -f request_pipe
  rm -f response_pipe
  mkfifo request_pipe
  mkfifo response_pipe
  cat request_pipe | nc -l 8080 >> response_pipe &
  bash processrequest.bash < response_pipe >> request_pipe
done
