FROM library/debian:wheezy-slim

MAINTAINER Chris Diehl <cultclassik@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    apt-transport-https \
    libcurl3 && \
    rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://apt.z.cash/zcash.asc | sudo apt-key add - &&\
    echo "deb [arch=amd64] https://apt.z.cash/ jessie main" | sudo tee /etc/apt/sources.list.d/zcash.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    zcash && \
    rm -rf /var/lib/apt/lists/*

RUN zcash-fetch-params

### do conf file
RUN zcashd

CMD [ 'zcash-cli' ]