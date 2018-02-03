defmodule Bank.TransferProcess do
  use Commanded.ProcessManagers.ProcessManager,
    name: "TransferProcess",
    router: Bank.Router

  alias Bank.Transfer
  alias Bank.Commands, as: C
  alias Bank.Events, as: E

  defstruct []

  def interested?(%E.FundsRemoved{operation: %Transfer{} = o}) do
    {:start, o.transfer_id}
  end

  def interested?(%E.FundsAdded{operation: %Transfer{} = o}) do
    {:stop, o.transfer_id}
  end

  def handle(_, %E.FundsRemoved{} = evt) do
    %C.AddFunds{
      account_id: evt.operation.target_id,
      amount: evt.operation.amount,
      operation: evt.operation
    }
  end

  def apply(state, _event), do: state
end
