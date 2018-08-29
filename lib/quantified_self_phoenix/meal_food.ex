defmodule QuantifiedSelfPhoenix.MealFood do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias QuantifiedSelfPhoenix.{Repo, Food, Meal, MealFood}

  schema "meal_foods" do
    field :meal_id, :integer
    field :food_id, :integer
  end

  @doc false
  def changeset(meal_food, attrs) do
    meal_food
      |> cast(attrs, [:meal_id, :food_id])
      |> validate_required([:meal_id, :food_id])
  end

  def createMealFood(meal_id, food_id) do
      {:ok, result} = Repo.insert(%MealFood{meal_id: meal_id, food_id: food_id})
      result
  end

  def destroyMealFood(meal_id, food_id) do
    meal_food = Repo.one(from meal_food in "meal_foods", 
                              where: [meal_id: ^meal_id, food_id: ^food_id],
                              select: %{id: meal_food.id, meal_id: meal_food.meal_id, food_id: meal_food.food_id})
    Repo.delete(MealFood |> Repo.get(meal_food[:id]))
  end

end
