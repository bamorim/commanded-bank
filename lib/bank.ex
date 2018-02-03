defmodule Bank do
  @moduledoc """
  Documentation for Bank.
  """

  alias Bank.Router
  alias Bank.Commands, as: C

  def open_account do
    id = UUID.uuid4
    %C.OpenAccount{account_id: id}
    |> Router.dispatch
    |> case do
         :ok -> {:ok, id}
         err -> err
       end
  end

  def add_funds(_account_id, _amount) do
    {:error, :not_implemented}
  end

  def remove_funds(_account_id, _amount) do
    {:error, :not_implemented}
  end

  def transfer(_source_id, _target_id, _amount) do
    {:error, :not_implemented}
  end

  def get_balance(_account_id) do
    {:error, :not_implemented}
  end

  def get_statement(_account_id) do
    {:error, :not_implemented}
  end
end
