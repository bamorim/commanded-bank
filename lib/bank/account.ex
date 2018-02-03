defmodule Bank.Account do
  alias __MODULE__
  alias Bank.Commands, as: C
  alias Bank.Events, as: E

  defstruct []

  def execute(_, %C.OpenAccount{} = cmd) do
    %E.AccountOpened{account_id: cmd.account_id}
  end

  def apply(s, _), do: s
end
