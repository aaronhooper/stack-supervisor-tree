defmodule Stack.RootSupervisor do
  use Supervisor

  def start_link(init_stack) do
    result = {:ok, supervisor} = Supervisor.start_link(__MODULE__, init_stack, name: __MODULE__)
    {:ok, stash_pid} = Supervisor.start_child(supervisor, {Stack.Stash, init_stack})
    Supervisor.start_child(supervisor, {Stack.StackSupervisor, stash_pid})
    result
  end

  @impl true
  def init(_) do
    Supervisor.init([], strategy: :one_for_one)
  end
end
