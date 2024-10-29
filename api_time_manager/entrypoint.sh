mix ecto.reset
mix ecto.migrate
mix ecto.create
mix ecto.migrate
echo "Database $PG_DB created"
exec mix phx.server