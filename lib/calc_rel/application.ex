defmodule CalcRel.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [CalcRel.Repo]

    opts = [strategy: :one_for_one, name: CalcRel.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
