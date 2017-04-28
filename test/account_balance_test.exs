defmodule AccountBalanceTest do
  use ExUnit.Case
  doctest AccountBalance

  test "initializes the account" do
    {:ok, pid} = AccountBalance.start(0)
    assert is_pid(pid)
  end

  test "gets the balance" do
    {:ok, pid} = AccountBalance.start(0)
    assert {:ok, 0} = AccountBalance.get_balance(pid)
  end

  test "lodge an amount" do
    {:ok, pid} = AccountBalance.start(0)
    :ok = AccountBalance.lodge(pid, 100)

    assert {:ok, 100} = AccountBalance.get_balance(pid)
  end

  test "withdraw an amount" do
    {:ok, pid} = AccountBalance.start(0)
    :ok = AccountBalance.withdraw(pid, 100)

    assert {:ok, -100} = AccountBalance.get_balance(pid)
  end
end
