<<<<<<< HEAD
mix ecto.reset
mix ecto.migrate
=======
mix ecto.create
mix ecto.migrate
echo "Database $PG_DB created"
>>>>>>> docker
exec mix phx.server