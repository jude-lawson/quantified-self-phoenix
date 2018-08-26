defmodule QuantifiedSelfPhoenixWeb.Router do
  use QuantifiedSelfPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", QuantifiedSelfPhoenixWeb do
    pipe_through :api

    get "/foods", FoodsController, :index 
  end
end
