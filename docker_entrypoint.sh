#!/bin/bash
PROGNAME=$0

usage() {
  cat << EOF >&2
Usage: $PROGNAME [-r <refresh>] [-s <server>] [-p <port>] [-t <turbo>]

    -r <refresh>  tor IP refresh (seconds)  [60]
    -e <regions>  exit node regions         []
    -s  <server>  server ip or domain
    -p    <port>  server port               [80]
    -t   <turbo>  turbo                     [135]
EOF
  exit 1
}

refresh=60 port=80 turbo=135
while getopts r:e:s:p:t o; do
  case $o in
    (r) refresh=$OPTARG;;
    (e) exit_nodes=(${OPTARG//,/ });;
    (s) server=$OPTARG;;
    (p) port=$OPTARG;;
    (t) turbo=$OPTARG;;
    (*) usage
  esac
done

if [ ${#exit_nodes[@]} -ne 0 ]; then
  echo "StrictNodes 1" >> /etc/tor/torrc

  printf -v formatted_exit_nodes '{%s},' "${exit_nodes[@]}"
  echo "ExitNodes ${formatted_exit_nodes%,}" >> /etc/tor/torrc
fi

echo "MaxCircuitDirtiness $refresh" >> /etc/tor/torrc

service tor start

proxychains -q python3 DRipper.py -s "$server" -p "$port" -t "$turbo"
