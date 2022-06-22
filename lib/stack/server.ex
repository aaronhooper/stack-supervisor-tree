defmodule Stack.Server do
  use GenServer

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def push(element) do
    GenServer.cast(__MODULE__, {:push, element})
  end

  def pop() do
    GenServer.call(__MODULE__, :pop)
  end

  def stop() do
    GenServer.stop(__MODULE__)
  end

  @impl true
  def handle_cast({:push, element}, {stack, stash_pid}) do
    {:noreply, {[element | stack], stash_pid}}
  end

  @impl true
  def handle_call(:pop, _from, {[head | tail] = _stack, stash_pid}) do
    {:reply, head, {tail, stash_pid}}
  end

  @impl true
  def init(stash_pid) do
    stack = Stack.Stash.get(stash_pid)
    {:ok, {stack, stash_pid}}
  end

  @impl true
  def terminate(_reason, {stack, stash_pid}) do
    Stack.Stash.save(stash_pid, stack)
  end
end
