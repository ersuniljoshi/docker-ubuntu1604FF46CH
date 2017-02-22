FROM ubuntu:16.04
MAINTAINER "Sunil Joshi" <joshi.sunil@outlook.com>

LABEL name="Ubuntu 16.04 with updated repos and packages, FF 46, Chrome Latest, Geckodriver and ChromeDriver 2.27"
LABEL name="Docker image for the Robot Framework http://robotframework.org/"
LABEL usage="docker run -e Browser=browser -v $(pwd)/path/to/tests/:/path/to/tests/ -ti ubuntu1604ffch"

# Installing Dependency Packages
RUN apt-get -y update\
    && apt-get install -y libasound2 gconf-service wget  libnss3  libgconf-2-4 libnspr4-0d libnspr4 libnss3 libnss3-1d libappindicator1 libxss1 libpango1.0-0 xdg-utils fonts-liberation libexif12 xvfb unzip software-properties-common python-software-properties\
    && apt-get install -y python python-pip\ 
    && apt-get remove firefox\ 
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Installing FireFox
ENV FIREFOX_VERSION=46.0
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install firefox \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && wget --no-verbose -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 \
  && apt-get -y purge firefox \
  && rm -rf /opt/firefox \
  && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
  && rm /tmp/firefox.tar.bz2 \
  && mv /opt/firefox /opt/firefox-$FIREFOX_VERSION \
  && ln -fs /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox


# Installing Google Chrome Stable version along with all robotframework dependencies
ENV CHROME_VERSION="google-chrome-stable" 
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \ 
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && apt-get update -y \
    && apt-get -y install ${CHROME_VERSION:-google-chrome-stable} \
    && rm /etc/apt/sources.list.d/google-chrome.list \ 
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && pip install --upgrade pip \
    && pip install selenium==2.53.6\
    && pip install robotframework\
    && pip install robotframework-excellibrary\
    && pip install robotframework-requests\
    && pip install robotframework-sudslibrary\
    && pip install robotframework-xvfb\
    && pip install robotframework-selenium2library\
    && pip install robotframework-databaseslibrary\
    && cd /

# Installing and configuring Chrome Driver
ENV CHROME_DRIVER_VERSION=2.27 
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \ 
	&& rm -rf /opt/selenium/chromedriver \ 
	&& unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \ 
	&& rm /tmp/chromedriver_linux64.zip \ 
	&& mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \ 
	&& chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \ 
	&& ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver 


COPY chrome_launcher.sh /usr/bin/google-chrome
RUN chmod +x /usr/bin/google-chrome

CMD ["bash","/home/test/run.sh"]

