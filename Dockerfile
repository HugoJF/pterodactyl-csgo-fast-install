FROM        ubuntu:18.04

ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN         dpkg --add-architecture i386 \
            && apt-get update \
            && apt-get -y upgrade \
            && apt-get -y --no-install-recommends install curl lib32gcc1 ca-certificates \
            && useradd -m -d /home/container container

RUN 		cd /tmp
RUN 		curl -sSL -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz

RUN 		mkdir -p /usr/games/steamcmd
RUN 		tar -xzvf steamcmd.tar.gz -C /usr/games/steamcmd
RUN 		cd /mnt/server/steamcmd

# Create symbolic link to SteamCMD to keep compatibility with original Docker image
RUN 		mkdir -p /mnt/server/steamcmd
RUN 		ln -s /usr/games/steamcmd/steamcmd.sh /mnt/server/steamcmd/steamcmd.sh

# SteamCMD fails otherwise for some reason, even running as root.
# This is changed at the end of the install process anyways.
RUN 		chown -R root:root /mnt