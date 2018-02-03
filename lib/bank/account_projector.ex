defmodule Bank.AccountProjector do
  use Commanded.Projections.Ecto,
    name: "AccountProjector"

  alias Bank.Events, as: E
  alias Bank.Schemas, as: S

  """
  defp increase_balance(multi, account_id, amount) do
    Ecto.Multi.insert(
      :increase_balance,
      %S.Account{account_id: account_id, balance: amount},
      conflict_target: :account_id,
      on_conflict: [inc: [balance: amount]]
    )
  end
  """
end
