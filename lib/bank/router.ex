defmodule Bank.Router do
  use Commanded.Commands.Router

  alias Bank.Account
  alias Bank.Commands, as: C

  dispatch(
    [
      C.OpenAccount
    ],
    to: Account,
    identity: :account_id
  )
end
