defmodule QuantifiedSelfPhoenixWeb.MealFoodRequestTest do
  use QuantifiedSelfPhoenixWeb.ConnCase
  import Ecto.Query
  alias QuantifiedSelfPhoenix.{Repo, Food, Meal, MealFood}

  setup do
    Repo.query("DELETE FROM meals")
    Repo.query("ALTER SEQUENCE meals_id_seq RESTART WITH 1")
    Repo.insert_all(Meal, [
      %{name: "Breakfast"},
      %{name: "Snack"}
    ])

    Repo.query("DELETE FROM foods")
    Repo.query("ALTER SEQUENCE foods_id_seq RESTART WITH 1")
    Repo.insert_all(Food, [
      %{name: "Strawberries", calories: 900},
      %{name: "Cookies", calories: 800},
      %{name: "Chips", calories: 700}
    ])

    Repo.query("DELETE FROM meal_foods")
    Repo.query("ALTER SEQUENCE meal_foods_id_seq RESTART WITH 1")
    Repo.insert_all(MealFood, [
      %{meal_id: 1, food_id: 1},
      %{meal_id: 2, food_id: 2},
      %{meal_id: 2, food_id: 3}
    ])
    :ok
  end

  describe "POST /api/v1/meals/:meal_id/foods/:id" do
    test "should add the specified food to the specified meal" do
      {:ok, food} = Repo.insert(%Food{name: "Fajitas", calories: 1000})
      {:ok, meal} = Repo.insert(%Meal{name: "Lunch"})
      expected = %{ "message" => "Successfully added #{food.name} to #{meal.name}"}

      conn = build_conn()
              |> post("/api/v1/meals/#{meal.id}/foods/#{food.id}")
      
      body = conn |> json_response(201)

      new_meal_food = MealFood |> last |> Repo.one
      assert body == expected
      assert new_meal_food.food_id == food.id
      assert new_meal_food.meal_id == meal.id
    end

    test "should return a 404 if the meal is not found" do
      {:ok, food} = Repo.insert(%Food{name: "Fajitas", calories: 1000})
      expected = %{ "error" => "Meal with id 999 could not be found"}

      conn = build_conn()
              |> post("/api/v1/meals/999/foods/#{food.id}")
      
      body = conn |> json_response(404)

      assert body == expected
    end

    test "should return a 404 if the food is not found" do
      {:ok, meal} = Repo.insert(%Meal{name: "Lunch"})
      expected = %{ "error" => "Food with id 999 could not be found"}

      conn = build_conn()
              |> post("/api/v1/meals/#{meal.id}/foods/999")
      
      body = conn |> json_response(404)

      assert body == expected
    end
  end
end
