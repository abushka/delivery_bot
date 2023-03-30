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

ENTRYPOINT ["python", "-OO"]
CMD ["core.py"]

ENV PYTHONUNBUFFERED=1
ENV CONFIG_PATH="/usr/src/greed/config/config.toml"
ENV DB_ENGINE="postgresql://postgres:Abushka123@db:5432/postgres"

LABEL org.opencontainers.image.title="greed"
LABEL org.opencontainers.image.description="A customizable, multilanguage Telegram shop bot"
LABEL org.opencontainers.image.licenses="AGPL-3.0-or-later"
LABEL org.opencontainers.image.url="https://github.com/Steffo99/greed/"
LABEL org.opencontainers.image.authors="Stefano Pigozzi <me@steffo.eu>"