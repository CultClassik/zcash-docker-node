FROM library/debian:wheezy-slim

MAINTAINER Chris Diehl <cultclassik@gmail.com>

ENV ZEC_URL='https://z.cash/downloads/zcash-1.0.13-linux64.tar.gz'
ENV ZEC_ROOT='/zcash'

RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    apt-transport-https \
    libcurl3 && \
    rm -rf /var/lib/apt/lists/*

#RUN wget -qO - https://apt.z.cash/zcash.asc | sudo apt-key add - &&\
#    echo "deb [arch=amd64] https://apt.z.cash/ jessie main" | sudo tee /etc/apt/sources.list.d/zcash.list

#RUN apt-get update && apt-get install -y --no-install-recommends \
#    zcash && \
#    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN wget --no-check-certificate $ZEC_URL

RUN tar -xvf ./*.tar.gz

RUN mv -t /usr/local/bin/ zcash-1.0.13/bin/*

RUN zcash-fetch-params

RUN echo "rpcuser=root" >> ~/.zcash/zcash.conf

RUN echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >> ~/.zcash/zcash.conf

RUN echo "mainnet=1" >> ~/.zcash/zcash.conf

RUN echo "addnode=mainnet.z.cash" >> ~/.zcash/zcash.conf

### do conf file
#RUN zcashd

#CMD [ 'zcash-cli' ]
CMD ["zcashd"]