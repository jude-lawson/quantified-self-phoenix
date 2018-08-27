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
        %{"name" => "Tacos", "calories" => 900},
        %{"name" => "Dumplings", "calories" => 1000}
      ]
  
      response = get build_conn(), "/api/v1/foods"
      body = json_response(response, 200)
  
      assert body == expected
    end
  end
  
  describe "GET /api/v1/foods/:id" do
    test "should return the food specified by the given id" do
      expected = %{"name" => "Dumplings", "calories" => 1000}
  
      response = get build_conn(), "/api/v1/foods/2"
      body = json_response(response, 200)
  
      assert body == expected
    end
  end

  describe "POST /api/v1/foods" do
    test "should create a food in the database" do
      expected = %{ "food" => %{"name" => "Pizza", "calories" => 1200} }
      conn = build_conn()
              |> put_req_header("content-type", "application/json")
              |> post("/api/v1/foods", %{ food: %{name: "Pizza", calories: 1200} })
    
      body = conn |> json_response(200)

      assert body == expected
    end

    test "should return a 400 error if 'name' is not provided" do
    end

    test "should return a 400 error if 'calories' is not provided" do
    end
  end
end
