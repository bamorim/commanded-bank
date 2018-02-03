defmodule Bank.Commands do
  defmodule OpenAccount, do: defstruct [:account_id]
  defmodule AddFunds, do: defstruct [:account_id, :amount, :operation]
  defmodule RemoveFunds, do: defstruct [:account_id, :amount, :operation]
end
