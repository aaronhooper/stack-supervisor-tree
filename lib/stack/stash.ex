defmodule Stack.Stash do
  use GenServer

  def start_link(init_stack) do
    GenServer.start_link(__MODULE__, init_stack)
  end

  def get(stash_pid) do
    GenServer.call(stash_pid, :get)
  end

  def save(stash_pid, stack) do
    GenServer.cast(stash_pid, {:save, stack})
  end

  @impl true
  def init(init_stack) do
    {:ok, init_stack}
  end

  @impl true
  def handle_call(:get, _from, stack) do
    {:reply, stack, stack}
  end

  @impl true
  def handle_cast({:save, stack}, _state) do
    {:noreply, stack}
  end
end
