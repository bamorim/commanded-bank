defmodule Bank.Schemas.Account do
  use Ecto.Schema

  @primary_key {:account_id, :binary_id, autogenerate: false}

  schema "accounts" do
    field(:balance, :integer)
  end
end
