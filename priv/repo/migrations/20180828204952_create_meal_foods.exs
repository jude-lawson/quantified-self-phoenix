defmodule QuantifiedSelfPhoenix.Repo.Migrations.CreateMealFoods do
  use Ecto.Migration

  def change do
    create table(:meal_foods) do
      add :meal_id, :integer
      add :food_id, :integer
    end
  end
end
