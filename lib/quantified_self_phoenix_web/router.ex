defmodule QuantifiedSelfPhoenixWeb.Router do
  use QuantifiedSelfPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", QuantifiedSelfPhoenixWeb.Api.V1 do
    pipe_through :api

    get "/foods", FoodsController, :index
    get "/foods/:id", FoodsController, :show
    post "/foods", FoodsController, :create
    patch "/foods/:id", FoodsController, :edit
    delete "/foods/:id", FoodsController, :destroy
  end
end
