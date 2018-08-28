ExUnit.configure(timeout: :infinity)
ExUnit.start(trace: true)

Ecto.Adapters.SQL.Sandbox.mode(QuantifiedSelfPhoenix.Repo, :manual)

