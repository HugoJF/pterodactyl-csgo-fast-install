# Pterodactyl - CS:GO Fast Install image

This image will not fast install CS:GO by itself, it relies on a modified version of the daemon, and a file-system with COW support. The daemon will `cp -avrl` a CS:GO master-server directory before running the install script.

This image attempt to reduce the install script duration by pre-updating everything there is to update (Ubuntu and SteamCMD).

## Install

Build the image with
```sh
docker build -t fast-source-install /path/to/this/repository/files/
```

Then, update `Script container` for your desired nest to `~fast-source-install:latest`


## The new install script

Since most of the script is now contained inside the image, the only thing that we need to do, is "update" CS:GO and copy a file dependency.

```
#!/bin/bash
# CSGO Installation Script
#
# Server Files: /mnt/server

export HOME=/mnt/server
/usr/games/steamcmd/steamcmd.sh +login anonymous +force_install_dir /mnt/server +app_update 740 +quit

mkdir -p /mnt/server/.steam/sdk32
cp -v /usr/games/steamcmd/linux32/steamclient.so /mnt/server/.steam/sdk32/steamclient.so
```

---

After this, if your daemon is pre-cloning an updated CS:GO installation, you should be able to get a CS:GO server up and running (install, update, and run) in less then 60 seconds.
