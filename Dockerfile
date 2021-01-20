FROM debian:buster-slim AS app_builder

RUN apt-get update
RUN apt-get install -y make gcc libpq-dev
RUN mkdir -p /app
WORKDIR /app

COPY ./Makefile .
COPY ./pg_listen.c .

RUN make pg_listen

FROM debian:buster-slim AS app

ENV LANG=C.UTF-8

# psmisc provides killall, surprisingly in a smaller overall installation size than e.g. procps (pgrep, etc)
RUN apt-get update && apt-get install -y --no-install-recommends libpq5 psmisc && rm -rf /var/cache/apt

COPY --from=app_builder /app/pg_listen /usr/local/bin/pg_listen
CMD ["pg_listen"]
