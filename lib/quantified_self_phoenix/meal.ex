defmodule QuantifiedSelfPhoenix.Meal do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias QuantifiedSelfPhoenix.{Repo, Meal}

  schema "meals" do
    field :name, :string
  end

  @doc false
  def changeset(meal, attrs) do
    meal
      |> cast(attrs, [:name])
      |> validate_required([:name])
  end

end
