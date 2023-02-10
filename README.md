# dlk
Minimalist Kali Linux Docker - DockerLinuxKali aka dalak (:


## Usage


### Build with default ARGuments

```docker
docker build --rm -t dalak .
```

### Build with ARGuments

```docker
docker build --rm -t dalak --build-arg USER_NAME=your-username USER_PASSWD=your-passwd .
```

### ARGuments

| ARGument | Default | Description |
|----------|---------|-------------|
| USER_NAME | dalak | Username |
| USER_PASSWD | dalak | Password |
| ROOT_PASSWD | root | Root password |
| RDP_PORT | 3389 | RDP port |
| DESKROP_ENV | xfce | Desktop environment (kali-desktop-xfce) |
| SYSTEM_PKG | core | System packages (kali-linux-core)|

https://www.kali.org/docs/general-use/metapackages/
https://www.kali.org/tools/kali-meta/

### Run

```docker
docker run --rm -it -p 3389:3389 dalak
```