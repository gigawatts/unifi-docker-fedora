# unifi-fedora

## Description

This is a containerized version of [Ubiqiti Network](https://www.ubnt.com/)'s Unifi Controller version 5.

The repo I forked this from used a Debian base container which when run from a Fedora host, frequently uses a lot more memory to load all the Debian components. I have re-based this from Fedora to save some memory.

Use `docker run --net=host -d gigawatts/unifi-fedora:latest` to run it.

The following options may be of use:

- Set the timezone with `TZ`
- Bind mount the `data` and `log` volumes

Example to test with

```bash
mkdir -p ~host-src/unifi/data
mkdir -p ~host-src/unifi/logs
docker run --rm --net=host -e TZ='America/Chicago' -v ~/host-src/unifi/data:/opt/UniFi/data -v ~/host-src/unifi/logs:/opt/UniFi/logs --name unifi gigawatts/unifi-fedora:latest
```

## Volumes:

Configuration data: `/opt/UniFi/data`

Log files: `/opt/UniFi/logs`



## Environment Variables:

### `TZ`

TimeZone. (i.e America/Chicago)

## Expose:

### 8080/tcp - Device command/control

### 8443/tcp - Web interface + API

### 8843/tcp - HTTPS portal

### 8880/tcp - HTTP portal

### 3478/udp - STUN service

### 6789/tcp - Speed Test (unifi5 only)

### 10001/udp - UBNT Discovery

See [UniFi - Ports Used](https://help.ubnt.com/hc/en-us/articles/218506997-UniFi-Ports-Used)


## References

dumb-init
- https://copr.fedorainfracloud.org/coprs/alsadi/dumb-init/

Most of this code was borrowed from https://github.com/jacobalberty/unifi-docker
- I just modified package names and configs to run better from a Fedora host
