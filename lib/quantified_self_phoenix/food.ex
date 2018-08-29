defmodule QuantifiedSelfPhoenix.Food do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias QuantifiedSelfPhoenix.{Repo, Food}

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

  def createFood(new_food_data) do
    # new_food_data = params["food"]
    new_food = Repo.insert!(%Food{name: new_food_data["name"], calories: Integer.parse(new_food_data["calories"]) |> elem(0)})
    %{ food: %{ name: new_food.name, calories: new_food.calories } }
  end

  def editFood(id, updated_food_data) do
    food = Food |> Repo.get(id)
    changeset = Food.changeset(food, %{name: updated_food_data["name"], calories: updated_food_data["calories"]})
    {:ok, updated_food} = Repo.update(changeset)
    %{ food: %{ name: updated_food.name, calories: updated_food.calories } }
  end

  def deleteFood(id) do
    food = Food |> Repo.get(id)
    if !food do
      nil
    else
      food
    end 
  end
end
