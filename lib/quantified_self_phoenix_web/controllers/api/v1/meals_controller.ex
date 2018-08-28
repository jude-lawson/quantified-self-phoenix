defmodule QuantifiedSelfPhoenixWeb.Api.V1.MealsController do
  use QuantifiedSelfPhoenixWeb, :controller
  alias QuantifiedSelfPhoenix.Meal

  def index(conn, _params) do
    json conn, Meal.allMeals()
  end
end
