defmodule QuantifiedSelfPhoenixWeb.Router do
  use QuantifiedSelfPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", QuantifiedSelfPhoenixWeb.Api.V1 do
    pipe_through :api

    # Foods
    get "/foods", FoodsController, :index
    get "/foods/:id", FoodsController, :show
    post "/foods", FoodsController, :create
    patch "/foods/:id", FoodsController, :edit
    delete "/foods/:id", FoodsController, :destroy

    # Meals
    get "/meals", MealsController, :index
    get "/meals/:meal_id/foods", MealsController, :show

    # MealFoods
    post "/meals/:meal_id/foods/:id", MealFoodsController, :create
    delete "/meals/:meal_id/foods/:id", MealFoodsController, :destroy
  end
end
