defmodule QuantifiedSelfPhoenix.Repo do
  use Ecto.Repo, otp_app: :quantified_self_phoenix

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
