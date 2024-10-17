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
