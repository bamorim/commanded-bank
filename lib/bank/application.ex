defmodule Bank.Application do
  @moduledoc false

  use Application

  def start(_type, args) do
    Bank.Supervisor.start_link(args)
  end
end
