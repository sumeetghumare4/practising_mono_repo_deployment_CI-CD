FROM oven/bun:1

WORKDIR /usr/src/app

ARG DATABASE_URL

COPY ./packages ./packages
COPY ./bun.lock ./bun.lock

COPY ./package.json ./package.json
COPY ./turbo.json ./turbo.json

COPY ./apps/websocket ./apps/websocket

RUN bun install
RUN DATABASE_URL=${DATABASE_URL} bun run db:generate

EXPOSE 8081

CMD ["bun", "run", "start:websocket"]