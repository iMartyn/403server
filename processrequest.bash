#!/bin/bash
r=read;e=echo
read method file protocol
echo $method $file $protocol >&2
read
#keep reading until we get an empty string (or is it eof?)
z=$r;while [ ${#z} -gt 2 ];do $r z;done

f=`echo $file|sed 's/[^a-z0-9_.-]//gi'`
protocol="HTTP/1.0"
response="$protocol 200 OK\r\n"
if [ -z $f ]; then
    f="403.html"
    response="$protocol 403 Service Temporarily Unavailable\r\n"
fi

if [ ! -f $f ]; then
    f="403.html"
    response="$protocol 403 Service Temporarily Unavailable\r\n"
fi

HEADER="${response}Content-Type: `file -ib $f`\nContent-Length: `stat -c%s $f`"
echo $HEADER
echo
cat $f
