#!/bin/bash
PROGNAME=$0

usage() {
  cat << EOF >&2
Usage: $PROGNAME [-r <refresh>] [-s <server>] [-p <port>] [-t <turbo>]

    -r <refresh>  tor IP refresh (seconds)  [60]
    -s  <server>  server ip or domain
    -p    <port>  server port               [80]
    -t   <turbo>  turbo                     [135]
EOF
  exit 1
}

refresh=60 port=80 turbo=135
while getopts r:s:p:t o; do
  case $o in
    (r) refresh=$OPTARG;;
    (s) server=$OPTARG;;
    (p) port=$OPTARG;;
    (t) turbo=$OPTARG;;
    (*) usage
  esac
done

echo "MaxCircuitDirtiness $refresh" >> /etc/tor/torrc

service tor start

proxychains -q python3 DRipper.py -s "$server" -p "$port" -t "$turbo"
