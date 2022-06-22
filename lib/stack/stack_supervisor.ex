defmodule Stack.StackSupervisor do
  use Supervisor

  def start_link(stash_pid) do
    Supervisor.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  @impl true
  def init(stash_pid) do
    Supervisor.init([{Stack.Server, stash_pid}], strategy: :one_for_one)
  end
end

