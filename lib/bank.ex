defmodule Bank do
  @moduledoc """
  Documentation for Bank.
  """

  alias Bank.Transfer
  alias Bank.Repo
  alias Bank.Router
  alias Bank.Commands, as: C
  alias Bank.Schemas, as: S

  def open_account do
    id = UUID.uuid4
    %C.OpenAccount{account_id: id}
    |> Router.dispatch
    |> case do
         :ok -> {:ok, id}
         err -> err
       end
  end

  def add_funds(account_id, amount) do
    %C.AddFunds{
      account_id: account_id,
      amount: amount
    }
    |> Router.dispatch
  end

  def remove_funds(account_id, amount) do
    %C.RemoveFunds{
      account_id: account_id,
      amount: amount
    }
    |> Router.dispatch
  end

  def transfer(source_id, target_id, amount) do
    %C.RemoveFunds{
      account_id: source_id,
      amount: amount,
      operation: %Transfer{
        transfer_id: UUID.uuid4,
        source_id: source_id,
        target_id: target_id,
        amount: amount
      }
    }
    |> Router.dispatch
  end

  def get_balance(account_id) do
    with {:ok, acc} <- get_account(account_id),
      do: {:ok, acc.balance}
  end

  def get_statement(account_id) do
    with {:ok, acc} <- get_account(account_id),
    do: {:ok, Repo.all(statement_query(account_id))}
  end

  defp statement_query(account_id) do
    import Ecto.Query

    from t in S.Transaction,
      where: t.account_id == ^account_id
  end

  defp get_account(account_id) do
    case Repo.get(S.Account, account_id) do
      nil ->
        {:error, :not_found}
      acc ->
        {:ok, acc}
    end
  end
end
