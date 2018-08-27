defmodule QuantifiedSelfPhoenixWeb.FoodRequestsTest do
  use QuantifiedSelfPhoenixWeb.ConnCase
  alias QuantifiedSelfPhoenix.{Repo, Food}

  setup do
    Repo.query("DELETE FROM foods")
    Repo.query("ALTER SEQUENCE foods_id_seq RESTART WITH 1")
    Repo.insert(%Food{name: "Tacos", calories: 900})
    Repo.insert(%Food{name: "Dumplings", calories: 1000})
    :ok
  end

  describe "GET /api/v1/foods" do
    test "should get all persisted foods from the foods table" do
      expected = [
        %{name: "Tacos", calories: 900},
        %{name: "Dumplings", calories: 1000}
      ]
  
      response = get build_conn(), "/api/v1/foods"
      body = json_response(response, 200)
  
      assert length(body) == length(expected)
      assert Enum.at(body, 0)["name"] == Enum.at(expected, 0)[:name]
      assert Enum.at(body, 0)["calories"] == Enum.at(expected, 0)[:calories]
      
      assert Enum.at(body, 1)["name"] == Enum.at(expected, 1)[:name]
      assert Enum.at(body, 1)["calories"] == Enum.at(expected, 1)[:calories]
    end
  end
  
  describe "GET /api/v1/foods/:id" do
    test "should return the food specified by the given id" do
      expected = %{name: "Dumplings", calories: 1000}
  
      response = get build_conn(), "/api/v1/foods/2"
      body = json_response(response, 200)
  
      assert body["name"] == expected[:name]
      assert body["calories"] == expected[:calories]
    end
  end

  describe "POST /api/v1/foods" do
    test "should create a food in the database" do
      expected = %{ food: %{name: "Pizza", calories: 1200} }

      conn = build_conn()
              |> post("/api/v1/foods", food: "cool")
              |> put_req_header("content-type", "application/json")

      body = conn() |> response(200)

      assert body["food"]["name"] == expected[:food][:name]
      assert body["food"]["calories"] == expected[:food][:calories]
    end

    test "should return a 400 error if 'name' is not provided" do
    end

    test "should return a 400 error if 'calories' is not provided" do
    end
  end
end
