defmodule QuantifiedSelfPhoenixWeb.Api.V1.FoodsController do
  use QuantifiedSelfPhoenixWeb, :controller
  alias QuantifiedSelfPhoenix.Food

  def index(conn, _params) do
    json conn, Food.allFoods()
  end
end
