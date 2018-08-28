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
    # if params["food"]["name"] do
    #   json conn, Food.createFood(params["food"])
    # els
    #   json conn |> put_status(400), %{ error: "Attribute 'name' is required"}
    # end
      cond do
        !params["food"]["name"] -> 
          json conn |> put_status(400), %{ error: "Attribute 'name' is required"}
        !params["food"]["calories"] -> 
          json conn |> put_status(400), %{ error: "Attribute 'calories' is required"}
        params["food"]["name"] && params["food"]["calories"] ->
          json conn, Food.createFood(params["food"])
      end
  end
end
