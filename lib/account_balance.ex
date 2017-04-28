defmodule AccountBalance do
  @moduledoc """
  Documentation for AccountBalance.
  """

  def start(initial_value) do
    Agent.start(fn -> initial_value end)
  end

  def get_balance(pid) do
    Agent.get(pid, fn(value) -> {:ok, value} end)
  end

  def lodge(pid, amount) do
    Agent.update(pid, fn(value) -> value + amount end)
  end

  def withdraw(pid, amount) do
    Agent.update(pid, fn(value) -> value - amount end)
  end
end
