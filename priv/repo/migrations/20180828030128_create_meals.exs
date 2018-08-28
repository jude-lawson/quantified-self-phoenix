defmodule QuantifiedSelfPhoenix.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string
    end
  end
end
