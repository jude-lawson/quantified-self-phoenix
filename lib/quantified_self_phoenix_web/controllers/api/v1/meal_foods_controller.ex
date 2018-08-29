defmodule QuantifiedSelfPhoenixWeb.Api.V1.MealFoodsController do
  use QuantifiedSelfPhoenixWeb, :controller
  alias QuantifiedSelfPhoenix.{Repo, Food, Meal, MealFood}

  def create(conn, params) do
    meal_id = Integer.parse(params["meal_id"]) |> elem(0)
    food_id = Integer.parse(params["id"]) |> elem(0)

    meal = Meal |> Repo.get(meal_id)
    food = Food |> Repo.get(food_id)
    cond do
      !meal ->
        json conn |> put_status(404), %{ error: "Meal with id #{meal_id} could not be found"}
      !food ->
        json conn |> put_status(404), %{ error: "Food with id #{food_id} could not be found"}
      food && meal ->
        MealFood.createMealFood(meal_id, food_id)
        json conn |> put_status(201), %{ message: "Successfully added #{food.name} to #{meal.name}"}
    end
  end
end
