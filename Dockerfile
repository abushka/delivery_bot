FROM python:3.10 AS dependencies
RUN apt-get update && apt-get install -y build-essential python3-dev python3-pip musl-dev && ln -s /usr/lib/x86_64-linux-gnu/libc.so /lib/libc.musl-x86_64.so.1

WORKDIR /usr/src/greed
COPY ./requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --requirement requirements.txt

#############################################################################

FROM python:3.10-slim AS final

COPY --from=dependencies /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages

WORKDIR /usr/src/greed
COPY . /usr/src/greed
