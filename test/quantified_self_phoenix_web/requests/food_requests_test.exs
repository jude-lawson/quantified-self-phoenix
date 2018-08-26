defmodule QuantifiedSelfPhoenixWeb.FoodRequestsTest do
  use QuantifiedSelfPhoenixWeb.ConnCase
  
  test "GET /foods", %{conn: conn} do
    response = get conn, "/api/v1/foods"
    body = json_response(response, 200)
    assert body == %{}
  end
end
