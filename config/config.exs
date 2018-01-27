use Mix.Config

config :bank,
  ecto_repos: [Bank.Repo]

config :bank, Bank.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "bank_readstore_dev",
  hostname: "localhost",
  port: 5432,
  pool_size: 10

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

# Configure the event store database
config :eventstore, EventStore.Storage,
  serializer: EventStore.TermSerializer,
  username: "postgres",
  password: "postgres",
  database: "bank_eventstore_dev",
  hostname: "localhost",
  port: 5432,
  pool_size: 10
