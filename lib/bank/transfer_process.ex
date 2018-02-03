defmodule Bank.TransferProcess do
  use Commanded.ProcessManagers.ProcessManager,
    name: "TransferProcess",
    router: Bank.Router

  alias Bank.Commands, as: C
  alias Bank.Events, as: E

  defstruct []

  def handle(state, event)

  def apply(state, event)
end
