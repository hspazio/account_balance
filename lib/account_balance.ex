defmodule AccountBalance do
  @moduledoc """
  Documentation for AccountBalance.
  """

  def start(initial_value) do
    {:ok, spawn(AccountBalance, :loop, [initial_value])}
  end

  def loop(balance) do
    receive do
      {from, ref, :get_balance} ->
        send(from, {:ok, ref, balance})
        loop(balance)
      {:lodge, amount} ->
        loop(balance + amount)
      {:withdraw, amount} ->
        loop(balance - amount)
    end
  end

  def get_balance(pid) do
    ref = make_ref()
    send(pid, {self(), ref, :get_balance})

    receive do
      {:ok, ^ref, balance} -> {:ok, balance}
    end
  end

  def lodge(pid, amount) do
    send(pid, {:lodge, amount})
    :ok
  end

  def withdraw(pid, amount) do
    send(pid, {:withdraw, amount})
    :ok
  end
end
