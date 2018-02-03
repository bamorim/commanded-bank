defmodule Bank.Schemas.Transaction do
  use Ecto.Schema

  schema "transactions" do
    field(:account_id, :string)
    field(:amount, :integer)
  end
end
