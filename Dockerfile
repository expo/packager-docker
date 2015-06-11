FROM iojs

MAINTAINER Charlie Cheever <exponent.team@gmail.com>

RUN git clone https://github.com/facebook/watchman.git /tmp/watchman
WORKDIR /tmp/watchman
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

RUN npm install -g gulp coffee-script nesh adduser-async
RUN nesh --disable doc
RUN nesh --enable nesh-co
RUN nesh --enable nesh-doc

RUN mkdir -p /var/exponent-packager
WORKDIR /var/exponent-packager
RUN NODE_PATH=$NODE_PATH:$(npm -g root) node -e "require('adduser-async').addUserIfNotExistsAsync('exponent').then(console.log, console.error);"
RUN chown -R exponent .
USER exponent
ADD package.json package.json
ADD runPackager.js runPackager.js
RUN npm install

CMD ["nesh", "-y"]
CMD ["bash"]
CMD ["node", "./runPackager.js"]
