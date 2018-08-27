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
    json conn, Food.createFood(params)
  end
end
