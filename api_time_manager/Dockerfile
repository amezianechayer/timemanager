<<<<<<< HEAD
FROM elixir:1.14.5-alpine AS build

RUN apk add --no-cache build-base npm git

WORKDIR /app

COPY mix.exs mix.lock ./
COPY config ./config

RUN mix local.hex --force && mix deps.get

COPY . .

RUN mix compile

FROM elixir:1.14.5-alpine

RUN apk add --no-cache openssl

WORKDIR /app

COPY --from=build /app/_build /app/_build

EXPOSE 4000

CMD ["mix", "phx.server"]
=======
FROM elixir:latest

RUN mkdir /api_time_manager
COPY . /api_time_manager
WORKDIR /api_time_manager

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.update --all

RUN mix do compile

# Expose port 4000
EXPOSE 4000

CMD ["bash", "entrypoint.sh"]
>>>>>>> docker
