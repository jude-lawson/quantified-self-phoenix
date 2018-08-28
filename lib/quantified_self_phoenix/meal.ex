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

  def allMeals() do
    {:ok, result} = Repo.query("SELECT meals.*, json_agg(foods.*) FROM meal_foods
                         INNER JOIN meals ON meal_foods.meal_id = meals.id
                         INNER JOIN foods ON meal_foods.food_id = foods.id
                         GROUP BY meals.id")
    Enum.map(result.rows, fn row ->
      %{id: row |> Enum.at(0), 
        name: row |> Enum.at(1),
        foods: Enum.map(row |> Enum.at(2), fn food -> %{id: food["id"], name: food["name"], calories: food["calories"]} end)
       } end)
  end

end
