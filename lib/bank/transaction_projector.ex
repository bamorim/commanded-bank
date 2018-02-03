defmodule Bank.TransactionProjector do
  use Commanded.Projections.Ecto,
    name: "TransactionProjector"

  alias Bank.Events, as: E
  alias Bank.Schemas, as: S

  project %E.FundsAdded{} = evt do
    add_transaction(multi, evt.account_id, evt.amount)
  end

  project %E.FundsRemoved{} = evt do
    add_transaction(multi, evt.account_id, -evt.amount)
  end

  defp add_transaction(multi, id, amount) do
    Ecto.Multi.insert(
      multi,
      :add_transaction,
      %S.Transaction{account_id: id, amount: amount}
    )
  end
end
