defmodule QuantifiedSelfPhoenixWeb.Router do
  use QuantifiedSelfPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QuantifiedSelfPhoenixWeb do
    pipe_through :api
  end
end
