defmodule QuantifiedSelfPhoenixWeb.Api.V1.FoodsController do
  use QuantifiedSelfPhoenixWeb, :controller
  alias QuantifiedSelfPhoenix.Food

  def index(conn, _params) do
    json conn, Food.allFoods()
  end

  def show(conn, params) do
    json conn, Food.findFood(Integer.parse(params["id"]) |> elem(0))
  end

  def create(conn, params) do
    cond do
      !params["food"]["name"] && !params["food"]["calories"] ->
        json conn |> put_status(400), %{ error: "Attributes 'name' and 'calories' are both required" }
      !params["food"]["name"] -> 
        json conn |> put_status(400), %{ error: "Attribute 'name' is required" }
      !params["food"]["calories"] -> 
        json conn |> put_status(400), %{ error: "Attribute 'calories' is required" }
      params["food"]["name"] && params["food"]["calories"] ->
        json conn, Food.createFood(params["food"])
    end
  end

  def edit(conn, params) do
    updated_food_data = params["food"]

    cond do
      updated_food_data["name"] && updated_food_data["calories"] ->
        json conn, Food.editFood(Integer.parse(params["id"]) |> elem(0), updated_food_data)
      !updated_food_data["name"] || !updated_food_data["calories"] ->
        json conn |> put_status(400), %{ error: "An error has occurred updating the food" }
    end
  end

  def destroy(conn, params) do
    result = Food.deleteFood(params["id"])
    if !result do
      json conn |> put_status(404), %{ message: "The food with the id #{params["id"]} could not be found"}
    else
      json conn |> put_status(204), %{ message: "'#{result.name}' has been deleted"}
    end
  end
end
