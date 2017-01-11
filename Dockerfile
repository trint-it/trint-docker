FROM node:6-slim
MAINTAINER Norman Khine <norman@trint.com> (http://trint.com/)

RUN apt-get update \
  && apt-get install -y python2.7 make g++ git bzip2 libfreetype6 libfontconfig1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && ln -s /usr/bin/python2.7 /usr/bin/python

RUN cd $(npm root -g)/npm \
  && npm install -g yarn \
  && npm install fs-extra \
  && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.move/fs.rename/ ./lib/utils/rename.js

RUN cd /tmp && yarn add bcrypt \
  && rm -Rf node_modules/ffprobe-static/bin/darwin \
  && rm -Rf node_modules/ffprobe-static/bin/win32

CMD ["yarn", "--version"]
