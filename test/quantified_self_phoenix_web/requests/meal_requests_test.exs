defmodule QuantifiedSelfPhoenixWeb.MealRequestTest do
  use QuantifiedSelfPhoenixWeb.ConnCase
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
      %{name: "Cookies", calories: 800},
      %{name: "Chips", calories: 700},
      %{name: "Strawberries", calories: 900}
    ])

    Repo.query("DELETE FROM meal_foods")
    Repo.query("ALTER SEQUENCE meal_foods_id_seq RESTART WITH 1")
    Repo.insert_all(MealFood, [
      %{meal_id: 2, food_id: 1},
      %{meal_id: 2, food_id: 2},
      %{meal_id: 1, food_id: 3}
    ])
    :ok
  end

  describe "GET /api/v1/meals" do
    test "should return all meals in the database" do
      expected = [
        %{"id" => 1, "name" => "Breakfast", "foods" => [
          %{"id" => 3, "name" => "Strawberries", "calories" => 900}
        ]},
        %{"id" => 2, "name" => "Snack", "foods" => [
          %{"id" => 1, "name" => "Cookies", "calories" => 800},
          %{"id" => 2, "name" => "Chips", "calories" => 700}
        ]}
      ]

      conn = build_conn()
              |> get("/api/v1/meals")
      
      body = conn |> json_response(200)

      assert body == expected
    end
  end
end
