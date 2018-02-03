defmodule Bank.Account do
  alias __MODULE__
  alias Bank.Commands, as: C
  alias Bank.Events, as: E

  defstruct [opened: false, balance: 0]

  def execute(_, %C.OpenAccount{} = cmd) do
    %E.AccountOpened{account_id: cmd.account_id}
  end
  def execute(%{opened: false}, _), do: {:error, :not_found}
  def execute(_, %C.AddFunds{} = cmd) do
    %E.FundsAdded{
      account_id: cmd.account_id,
      amount: cmd.amount,
      operation: cmd.operation
    }
  end
  def execute(%{balance: b}, %C.RemoveFunds{amount: a}) when a > b do
    {:error, :insufficient_funds}
  end
  def execute(_, %C.RemoveFunds{} = cmd) do
    %E.FundsRemoved{
      account_id: cmd.account_id,
      amount: cmd.amount,
      operation: cmd.operation
    }
  end

  def apply(_, %E.AccountOpened{} = evt) do
    %Account{
      opened: true,
      balance: 0
    }
  end
  def apply(s, %E.FundsAdded{} = evt), do: add_funds(s, evt.amount)
  def apply(s, %E.FundsRemoved{} = evt), do: add_funds(s, -evt.amount)
  def apply(s, _), do: s


  defp add_funds(s, amount) do
    %Account{s | balance: s.balance + amount}
  end
end
