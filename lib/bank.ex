defmodule Bank do
  @moduledoc """
  Documentation for Bank.
  """

  def open_account do
    {:ok, nil}
  end

  def add_funds(account_id, amount) do
    :ok
  end

  def remove_funds(account_id, amount) do
    :ok
  end

  def transfer(source_id, target_id, amount) do
    :ok
  end

  def get_balance(account_id) do
    {:ok, nil}
  end

  def get_statement(account_id) do
    {:ok, nil}
  end
end
