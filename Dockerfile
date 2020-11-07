# czsip/fiji with additional xvfb support
# Author: Robert Kirmse
# Version: 0.1

# Pull base CZSIP/Fiji.
# FROM czsip/fiji_linux64_baseimage:1.2.8
FROM czsip/fiji_linux64_baseimage:latest
# FROM czsip/fiji

#get additional stuff
#RUN apt-get update; exit 0 && \
RUN apt-get update
RUN    apt-get install -y \
        apt-utils \
        software-properties-common && \   
    apt-get upgrade -y
 
# get Xvfb virtual X server and configure
RUN apt-get install -y \
        xvfb \
        x11vnc \
        x11-xkb-utils \
        xfonts-100dpi \
        xfonts-75dpi \
        xfonts-scalable \
        xfonts-cyrillic \
        x11-apps \
        libxrender1 \
        libxtst6 \
        libxi6
                           
# Install additional Fiji Plugins
COPY ./*.ijm /
COPY ./start.sh /
COPY ./font.conf /etc/fonts/fonts.conf
#COPY ./Apeer_MacroExt* /Fiji.app/plugins
ADD https://github.com/miura/APEER_MacroExtension/releases/download/v0.2.1/Apeer_MacroExt-0.2.1-SNAPSHOT.jar /Fiji.app/plugins/
COPY ./module_specification.json .

VOLUME [ "/input", "/output", "/params" ]

# Setting ENV for Xvfb and Fiji
ENV DISPLAY :99
ENV PATH $PATH:/Fiji.app/
#RUN xvfb-run -a /Fiji.app/ImageJ-linux64 --update update

# Entrypoint for Fiji script has to be added below!
ENTRYPOINT ["sh","/start.sh"]
