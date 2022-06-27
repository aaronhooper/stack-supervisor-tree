## Usage

Install dependencies with `mix deps.get`, then open in `iex` with `iex -S mix`.

```elixir
iex(1)> Stack.Server.push "world"
:ok
iex(2)> Stack.Server.push "hello"
:ok
iex(3)> :sys.get_state Stack.Server
{["hello", "world"], #PID<0.152.0>}
iex(4)> Stack.Server.pop
"hello"
iex(5)> :sys.get_state Stack.Server
{["world"], #PID<0.152.0>}
```

```elixir
# Stopping the server will save the state.
# When the supervisor restarts the process, the state will be retrieved.
iex(6)> Stack.Server.stop
:ok
iex(7)> :sys.get_state Stack.Server
{["world"], #PID<0.152.0>}
```

