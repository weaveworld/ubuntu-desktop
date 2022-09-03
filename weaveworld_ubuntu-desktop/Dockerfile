FROM weaveworld/ubuntu:u20-20220901

# X, LXDE

RUN apt-get -qy install \
        xvfb x11vnc novnc pulseaudio \
        xdg-utils 
RUN mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

RUN apt-get -qy install --no-install-recommends \
        lxde 
        
RUN apt-get -qqy install --no-install-recommends \
    libfontconfig libfreetype6 xfonts-scalable ttf-ubuntu-font-family fonts-liberation \
    xfonts-cyrillic fonts-ipafont-gothic fonts-wqy-zenhei fonts-tlwg-loma-otf fonts-noto-color-emoji

RUN mkdir -p /var/run/supervisor/ && chmod 1777 /var/run/supervisor

RUN chmod +x /dev/shm

# BROWSERS

RUN apt-get -qy install \
        firefox

RUN wget -P /tmp/install https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get -qqy install /tmp/install/google-chrome-stable_current_amd64.deb 

RUN wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg \
    && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list \
    && sudo apt-get update \
    && sudo apt-get -qy install microsoft-edge-stable

RUN CHROME=$(readlink -f /usr/bin/google-chrome); \ 
  mv ${CHROME} ${CHROME}-base \
  && echo "#!/bin/bash\numask 002\n\
exec -a \"\$0\" ${CHROME}-base --no-sandbox --disable-fre --no-default-browser-check --no-first-run \"\$@\" " > ${CHROME} && chmod 4755 ${CHROME} 

RUN EDGE=$(readlink -f /usr/bin/microsoft-edge); \
  mv ${EDGE} ${EDGE}-base \
  && echo "#!/bin/bash\numask 002\n\
exec -a \"\$0\" ${EDGE}-base --no-sandbox --disable-fre --no-default-browser-check --no-first-run \"\$@\" " > ${EDGE} && chmod 4755 ${EDGE} 

RUN sed -i -e "s|google-chrome-stable|google-chrome|" /usr/share/applications/google-chrome.desktop
RUN sed -i -e "s|microsoft-edge-stable|microsoft-edge|" /usr/share/applications/microsoft-edge.desktop

RUN apt-get -fqy install && apt autoclean -qy && apt autoremove -qy

# USER `app`

ENV USER=app
ENV HOME=/home/app

RUN groupadd ${USER} --gid 1111 \
  && useradd ${USER} --gid 1111 --uid 1111 --create-home --shell /bin/bash \
  && usermod -a -G sudo ${USER} \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo "${USER}:${USER}" | chpasswd

# ROOT FS

ADD fs /
RUN chmod +x /etc/startup.sh

ENV DISPLAY_WIDTH=1600
ENV DISPLAY_HEIGHT=900  

# USER HOME

USER 1111:1111

ADD home ${HOME}/
RUN sudo chown -R ${USER}:${USER} ${HOME} /app && sudo chmod -R 777 ${HOME} /app
  
RUN mkdir -p ${HOME}/Desktop && bash -c "cp /usr/share/applications/{firefox,google-chrome,microsoft-edge}.desktop ${HOME}/Desktop/"

# START

CMD ["/etc/startup.sh"]