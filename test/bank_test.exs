defmodule BankTest do
  use ExUnit.Case
  doctest Bank

  test "accounts start with 0 balance" do
    {:ok, account_id} = Bank.open_account()
    wait_until(fn ->
      assert {:ok, 0} = Bank.get_balance(account_id)
    end)
  end

  test "we can add funds" do
    {:ok, account_id} = Bank.open_account()
    :ok = Bank.add_funds(account_id, 100)
    wait_until(fn ->
      assert {:ok, 100} = Bank.get_balance(account_id)
    end)
  end

  test "we can remove funds" do
    {:ok, account_id} = Bank.open_account()
    :ok = Bank.add_funds(account_id, 100)
    :ok = Bank.remove_funds(account_id, 10)
    wait_until(fn ->
      assert {:ok, 90} = Bank.get_balance(account_id)
    end)
  end

  test "we can't remove funds without money" do
    {:ok, account_id} = Bank.open_account()
    resp = Bank.remove_funds(account_id, 10)
    assert {:error, :insufficient_funds} = resp
  end

  test "we can transfer money" do
    {:ok, source_id} = Bank.open_account()
    {:ok, target_id} = Bank.open_account()
    :ok = Bank.add_funds(source_id, 100)
    :ok = Bank.transfer(source_id, target_id, 10)
    wait_until(fn ->
      assert {:ok, 90} = Bank.get_balance(source_id)
      assert {:ok, 10} = Bank.get_balance(target_id)
    end)
  end

  test "we can't transfer without money" do
    {:ok, source_id} = Bank.open_account()
    {:ok, target_id} = Bank.open_account()
    resp = Bank.transfer(source_id, target_id, 10)
    assert {:error, :insufficient_funds} = resp
  end

  test "we can get the statement of transactions" do
    {:ok, source_id} = Bank.open_account()
    {:ok, target_id} = Bank.open_account()
    :ok = Bank.add_funds(source_id, 100)
    :ok = Bank.transfer(source_id, target_id, 10)
    wait_until(fn ->
      {:ok, source_txs} = Bank.get_statement(source_id)
      {:ok, target_txs} = Bank.get_statement(target_id)
      assert [_, _] = source_txs
      assert [_] = target_txs
    end)
  end

  # Async test helper
  defp wait_until(fun), do: wait_until(200, fun)
  defp wait_until(t, fun) when t <= 0, do: fun.()
  defp wait_until(timeout, fun) do
    fun.()
  rescue
    _ ->
      :timer.sleep(10)
    wait_until(max(0, timeout - 10), fun)
  end
end
