defmodule QuantifiedSelfPhoenix.Food do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias QuantifiedSelfPhoenix.Repo


  schema "foods" do
    field :calories, :integer
    field :name, :string
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [:name, :calories]) # Basically strong params
    |> validate_required([:name, :calories]) # Pretty straightforward validation
  end

  def allFoods() do
    Repo.all(from f in "foods", 
                  select: %{name: f.name, calories: f.calories})
  end

  def findFood(id) do
    Repo.one(from f in "foods",
                  where: f.id == ^id,
                  select: %{name: f.name, calories: f.calories})
  end
end
