defmodule Bank.AccountProjector do
  use Commanded.Projections.Ecto,
    name: "AccountProjector"

  alias Bank.Events, as: E
  alias Bank.Schemas, as: S

  project %E.AccountOpened{account_id: id} do
    Ecto.Multi.insert(
      multi,
      :insert_account,
      %S.Account{account_id: id, balance: 0}
    )
  end

  project %E.FundsAdded{} = evt do
    increase_balance(multi, evt.account_id, evt.amount)
  end

  project %E.FundsRemoved{} = evt do
    increase_balance(multi, evt.account_id, -evt.amount)
  end

  defp increase_balance(multi, account_id, amount) do
    Ecto.Multi.insert(
      multi,
      :increase_balance,
      %S.Account{account_id: account_id, balance: amount},
      conflict_target: :account_id,
      on_conflict: [inc: [balance: amount]]
    )
  end
end
