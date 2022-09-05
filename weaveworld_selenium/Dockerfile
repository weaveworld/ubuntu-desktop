ARG DATE_VERSION=20220901
FROM weaveworld/ubuntu-desktop:u20-${DATE_VERSION}

USER root

# SELENIUM DRIVERS

RUN apt-get -qy install --no-install-recommends jq

RUN V=$(curl  -sL 'https://api.github.com/repos/mozilla/geckodriver/tags' | jq -r '.[0].name') ; \
  echo $V >/etc/geckodriver-version \
  && wget -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/$V/geckodriver-$V-linux64.tar.gz \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /opt/geckodriver /usr/bin/geckodriver && chmod 755 /usr/bin/geckodriver

RUN C_V=$(google-chrome -version | grep -o -P '([0-9]+)' | head -1); V=$(wget -O - "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${C_V}"); \
  echo $V >/etc/chromedriver-version \
  && wget -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$V/chromedriver_linux64.zip \
  && unzip /tmp/chromedriver_linux64.zip -d /opt \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/chromedriver /usr/bin/chromedriver && chmod 755 /usr/bin/chromedriver

RUN V=$(curl  -sL "https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/" | grep -o -P '(?<=https://msedgedriver.azureedge.net/)[^/]+(?=\/edgedriver_linux64.zip)' | head -1 ); \
  echo $V >/etc/msedgedriver-version \
  && wget -O /tmp/msedgedriver_linux64.zip https://msedgedriver.azureedge.net/$V/edgedriver_linux64.zip \
  && unzip /tmp/msedgedriver_linux64.zip -d /opt \
  && rm /tmp/msedgedriver_linux64.zip \
  && mv /opt/msedgedriver /usr/bin/msedgedriver && chmod 755 /usr/bin/msedgedriver

RUN mkdir /opt/selenium && wget -O /opt/selenium/selenium-server.jar --no-verbose https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.4.0/selenium-server-4.4.0.jar

ADD fs /
RUN chmod +x /etc/selenium_info

ARG GRAAL_VERSION=22.2.0
ARG JAVA_VERSION=17
ADD https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAAL_VERSION}/graalvm-ce-java${JAVA_VERSION}-linux-amd64-${GRAAL_VERSION}.tar.gz /tmp
RUN tar xfz /tmp/graalvm*.tar.gz -C /usr/share && mv /usr/share/graalvm* /usr/share/graalvm

USER 1111:1111

ENV JAVA_HOME="/usr/share/graalvm"
ENV PATH="/usr/share/graalvm/bin:${PATH}"
