FROM elixir:1.14.5-alpine AS build
RUN apk add --no-cache build-base npm git
WORKDIR /app
COPY mix.exs mix.lock ./
COPY config ./config
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get
COPY . .
RUN mix compile

FROM elixir:1.14.5-alpine
RUN apk add --no-cache openssl
WORKDIR /app
COPY --from=build /app/_build /app/_build
EXPOSE 4000
CMD ["mix", "phx.server"]
