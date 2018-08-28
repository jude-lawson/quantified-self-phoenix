# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     QuantifiedSelfPhoenix.Repo.insert!(%QuantifiedSelfPhoenix.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias QuantifiedSelfPhoenix.{Repo, Food, Meal, MealFood}

Repo.query("DELETE FROM foods")
Repo.query("ALTER SEQUENCE foods_id_seq RESTART WITH 1")

Repo.query("DELETE FROM meals")
Repo.query("ALTER SEQUENCE meals_id_seq RESTART WITH 1")

Repo.query("DELETE FROM meal_foods")
Repo.query("ALTER SEQUENCE meal_foods_id_seq RESTART WITH 1")

Repo.insert!(%Food{name: "Chicken", calories: 900})
Repo.insert!(%Food{name: "Pork", calories: 1100})
Repo.insert!(%Food{name: "Cookies", calories: 800})
Repo.insert!(%Food{name: "Chips", calories: 700})
Repo.insert!(%Food{name: "Strawberries", calories: 600})

Repo.insert!(%Meal{name: "Breakfast"})
Repo.insert!(%Meal{name: "Snack"})
Repo.insert!(%Meal{name: "Lunch"})
Repo.insert!(%Meal{name: "Dinner"})

Repo.insert!(%MealFood{meal_id: 1, food_id: 5})
Repo.insert!(%MealFood{meal_id: 2, food_id: 3})
Repo.insert!(%MealFood{meal_id: 2, food_id: 4})
Repo.insert!(%MealFood{meal_id: 3, food_id: 1})
Repo.insert!(%MealFood{meal_id: 4, food_id: 2})
