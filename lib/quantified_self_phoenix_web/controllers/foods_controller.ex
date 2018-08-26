defmodule QuantifiedSelfPhoenixWeb.FoodsController do
  use QuantifiedSelfPhoenixWeb, :controller

  def index(conn, _params) do
    json conn, %{}
  end
end
