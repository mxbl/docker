FROM ubuntu
MAINTAINER Maximilian Block <max@pool.math.tu-berlin.de>

# creating the wine user
# set user id for X sharing
RUN useradd -u _UID_ -d /home/wine -m -s /bin/bash wine
ENV HOME /home/wine
WORKDIR /home/wine

# force 32 bit architecture
ENV WINEPREFIX /home/wine/.wine
ENV WINEARCH win32

# disabling warning messages from wine, comment for debug purpose
ENV WINEDEBUG -all

# adding the link to the pulseaudio server
ENV PULSE_SERVER unix:/run/user/_UID_/pulse/native

# no user interaction during docker image build
ENV DEBIAN_FRONTEND noninteractive

# install wine and related packages
RUN dpkg --add-architecture i386 && \

    # updating and upgrading
    apt-get update && apt-get dist-upgrade -y && \

    # install software-properties-common to add ppas
    apt-get install -y --no-install-recommends \
        software-properties-common && \

    # adding required ppas
    #add-apt-repository ppa:graphics-drivers/ppa && \
    add-apt-repository ppa:ubuntu-wine/ppa && \
    apt-get update && \

    # install graphics driver
    #apt-get install -y --no-install-recommends \
    #    initramfs-tools nvidia-361 && \

    # install wine, winetricks and its utilities
    # temporary xvfb to install latest winetricks and its tricks
    apt-get install -y --no-install-recommends \
        wine1.8 cabextract unzip p7zip curl zenity xvfb && \
    curl -SL 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -o /usr/local/bin/winetricks && \
        chmod +x /usr/local/bin/winetricks && \

    # install winbind, stop ntlm error messages
    apt-get install -y --no-install-recommends \
        winbind && \

    # install p11, stop p11 kit error messages
    apt-get install -y --no-install-recommends \
        p11-kit-modules:i386 libp11-kit-gnome-keyring:i386 && \

    # install pulseaudio, support for wine sound
    apt-get install -y --no-install-recommends \
        pulseaudio:i386 libasound2-plugins:i386 && \

    # install of winetricks' tricks, comment if not needed
    su -p -l wine -c winecfg && \
    su -p -l wine -c 'xvfb-run -a winetricks -q corefonts' && \
    su -p -l wine -c 'xvfb-run -a winetricks -q xna40' && \
    su -p -l wine -c 'xvfb-run -a winetricks d3dx9' && \
    su -p -l wine -c 'xvfb-run -a winetricks -q directplay' && \

    # clean up
    apt-get autoremove -y --purge software-properties-common && \
    apt-get autoremove -y --purge xvfb && \
    apt-get autoremove -y --purge && \
    apt-get clean -y && \
    rm -rf /home/wine/.cache && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# launching the shell by default as wine user
USER wine
CMD /bin/bash
