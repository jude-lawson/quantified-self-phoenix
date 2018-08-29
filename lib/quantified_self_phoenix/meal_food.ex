defmodule QuantifiedSelfPhoenix.MealFood do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias QuantifiedSelfPhoenix.{Repo, Food, Meal, MealFood}

  schema "meal_foods" do
    field :meal_id, :integer
    field :food_id, :integer
  end

  def changeset(meal_food, attrs) do
    meal_food
      |> cast(attrs, [:meal_id, :food_id])
      |> validate_required([:meal_id, :food_id])
  end

  def createMealFood(meal_id, food_id) do
      {:ok, result} = Repo.insert(%MealFood{meal_id: meal_id, food_id: food_id})
      result
  end

end
