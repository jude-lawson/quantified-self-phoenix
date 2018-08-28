defmodule QuantifiedSelfPhoenixWeb.MealRequestTest do
  use QuantifiedSelfPhoenixWeb.ConnCase
  alias QuantifiedSelfPhoenix.{Repo, Food, Meal}

  setup do
    Repo.query("DELETE FROM meals")
    Repo.query("ALTER SEQUENCE meals_id_seq RESTART WITH 1")
    Repo.insert_all(Meal, [
      %{name: "Breakfast"},
      %{name: "Snack"}
    ])
    Repo.insert_all(Food, [
      %{name: "Cookies", calories: 800},
      %{name: "Chips", calories: 700}
    ])
    :ok
  end

  describe "GET /api/v1/meals" do
    test "should return all meal in the database" do
      expected = [
        %{"id" => 1, "name" => "Breakfast", "foods" => []},
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
