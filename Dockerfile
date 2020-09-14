FROM        ubuntu:18.04

ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN         dpkg --add-architecture i386 \
            && apt-get update \
            && apt-get -y upgrade \
            && apt-get -y --no-install-recommends install curl lib32gcc1 ca-certificates \
            && useradd -m -d /home/container container

# Download SteamCMD
RUN         cd /tmp
RUN         curl -sSL -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz

# Extract SteamCMD
RUN         mkdir -p /usr/games/steamcmd
RUN         tar -xzvf steamcmd.tar.gz -C /usr/games/steamcmd

# Run SteamCMD to update itself
RUN         /usr/games/steamcmd/steamcmd.sh +login anonymous +quit
