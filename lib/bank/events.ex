defmodule Bank.Events do
  defmodule AccountOpened, do: defstruct [:account_id]
  defmodule FundsAdded, do: defstruct [:account_id, :amount, :operation]
  defmodule FundsRemoved, do: defstruct [:account_id, :amount, :operation]
end
