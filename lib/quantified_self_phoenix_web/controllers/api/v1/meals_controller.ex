defmodule QuantifiedSelfPhoenixWeb.Api.V1.MealsController do
  use QuantifiedSelfPhoenixWeb, :controller
  alias QuantifiedSelfPhoenix.Meal

  def index(conn, _params) do
    json conn, Meal.allMeals()
  end

  def show(conn, params) do
    meal_id = Integer.parse(params["meal_id"]) |> elem(0)
    if meal = Meal.findMeal(meal_id) do
      json conn, meal
    else
      json conn |> put_status(404), %{ error: "Meal with id #{meal_id} was not found"}
    end
  end
end
