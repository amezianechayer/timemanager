FROM elixir:1.14-alpine AS build

RUN apk update && apk add --no-cache \
  build-base \
  git \
  npm \
  nodejs

WORKDIR /app

COPY mix.exs mix.lock ./

RUN mix do local.hex --force, local.rebar --force, deps.get --force

COPY . .

RUN mix deps.update heroicons && mix deps.get && mix compile 

CMD ["mix", "phx.server"]