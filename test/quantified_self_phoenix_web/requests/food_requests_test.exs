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

  test "GET /api/v1/foods", %{conn: conn} do
    expected = [
      %{name: "Tacos", calories: 900},
      %{name: "Dumplings", calories: 1000}
    ]

    response = get conn, "/api/v1/foods"
    body = json_response(response, 200)

    assert length(body) == length(expected)
    assert Enum.at(body, 0)["name"] == Enum.at(expected, 0)[:name]
    assert Enum.at(body, 0)["calories"] == Enum.at(expected, 0)[:calories]
    
    assert Enum.at(body, 1)["name"] == Enum.at(expected, 1)[:name]
    assert Enum.at(body, 1)["calories"] == Enum.at(expected, 1)[:calories]
  end

  test "GET /api/v1/foods/:id", %{conn: conn} do
    expected = %{name: "Dumplings", calories: 1000}

    response = get conn, "/api/v1/foods/2"
    body = json_response(response, 200)

    assert body["name"] == expected[:name]
    assert body["calories"] == expected[:calories]
  end
end
