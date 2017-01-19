FROM ubuntu:16.04

MAINTAINER "Sunil Joshi" <joshi.sunil@outlook.com>

LABEL name="Ubuntu 16.04 with updated repos and packages, FF 46, Chrome Latest, Geckodriver and ChromeDriver"

RUN apt-get -y update && apt-get install -y libasound2 gconf-service wget libnss3  libgconf-2-4 libnspr4-0d libnspr4 libnss3 libnss3-1d libappindicator1 libxss1 libpango1.0-0 xdg-utils fonts-liberation libexif12 xvfb\
    && apt-get install -y python python-pip && apt-get remove firefox && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copying all the installers.
COPY firefox-mozilla-build_46.0.1-0ubuntu1_amd64.deb /firefox-mozilla-build_46.0.1-0ubuntu1_amd64.deb
COPY google-chrome-stable_current_amd64.deb /google-chrome-stable_current_amd64.deb
COPY chromedriver /usr/bin/chromedriver
COPY geckodriver /usr/bin/geckodriver

RUN dpkg -i google-chrome-stable_current_amd64.deb\
    && rm google-chrome-stable_current_amd64.deb\
    && dpkg -i firefox-mozilla-build_46.0.1-0ubuntu1_amd64.deb\
    && rm firefox-mozilla-build_46.0.1-0ubuntu1_amd64.deb\
    && pip install --upgrade pip\
    && pip install selenium==2.53.6\
    && pip install robotframework\
    && pip install robotframework-excellibrary\
    && pip install robotframework-requests\
    && pip install robotframework-sudslibrary\
    && pip install robotframework-xvfb\
    && pip install robotframework-selenium2library\
    && pip install robotframework-databaseslibrary\
    && cd /

# RUN pip install selenium==3.0.2
# Copying executable file.

#=================================
# Chrome Launch Script Modication
#=================================
COPY chrome_launcher.sh /usr/bin/google-chrome
RUN chmod +x /usr/bin/google-chrome

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD ["run.sh"]

