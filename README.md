# Quantified Self Phoenix API
[![Waffle.io - Columns and their card count](https://badge.waffle.io/jude-lawson/quantified-self-phoenix.svg?columns=all)](https://waffle.io/jude-lawson/quantified-self-phoenix) 


## Summary

Quantified Self Phoenix API is an API built using Elixir and Phoenix for serving a Meal Diary interface. The frontend for that meal diary can be found [here](https://jude-lawson.github.io/quantified-self-fe-phoenix/). The backend API is hosted at [here](https://https://peaceful-dusk-38517.herokuapp.com). 

The api keeps track of foods and their calorie counts and relates those foods to specific meals (breakfast, lunch, snack, or dinner).

### Endpoints

`GET /api/v1/foods`
- Returns all foods currently in the database
- Payload:
```javascript
[
  {
    id: 1,
    name: 'Banana',
    calories: 100
  },
  {
    id: 2,
    name: 'Cookie',
    calories: '300'
  }
]
```

`GET /api/v1/foods/:id`
- Returns a single food with the provided id from the database
- Payload:
```javascript
{
  id: 12,
  name: 'Cookie',
  calories: 300
}
```

`POST /api/v1/foods`
- Adds a food to the database
- Receives a object (converted to JSON) like the one below:
```javascript
{
  food: {
    name: 'Dumplings',
    calories: 900
  }
}
```

`PATCH /api/v1/foods/:id`
- Updates the food with the given id in the database
- Receives and object (converted to JSON) like the one below:
```javascript
{
  food: {
    name: 'Flax Seed'
    calories: 50
  }
}
```

`DELETE /api/v1/foods/:id`
- Removes the food specified by the id from the database and associated meals
- If the food item is not found, a 404 will be returned

`GET /api/v1/meals`
- Returns all meals and their associated foods
- Payload:
```javascript
[
  {
    id: 1,
    name: 'Breakfast',
    foods: [
      {
        id: 1,
        name: 'Strawberries'
        calories: 200
      }
    ]
  },
  {
    id: 2
    name: 'Lunch'
    foods: [
      {
        id: 3,
        name: 'Sandwich'
        calories: 600
      },
      {
        id: 4,
        name: 'Chips'
        calories: 800
      }
    ]
  }
]
```

`GET /api/v1/meals/:meal_id/foods`
- Returns all of the associated foods for a specified meal
- Payload:
```javascript
{
  id: 2
  name: 'Lunch'
  foods: [
    {
      id: 3,
      name: 'Sandwich'
      calories: 600
    },
    {
      id: 4,
      name: 'Chips'
      calories: 800
    }
  ]
}
```

`POST /api/v1/meals/:meal_id/foods/:id`
- Adds a food to a specified meal
- Returns the following message with a 201 status if successful
```javascript
{
  message: 'Successfully added <food> to <meal>'
}
```
- Returns a 404 if the specified food or meal cannot be found


`DELETE /api/v1/meals/:meal_id/foods/:id`
- Removes the specified food from the specified meal
- Returns a 404 if the specified food or meal is not found
- Return the following message with a 201 status if successful
```javascript
{
  message: 'Successfully removed <food> from <meal>'
}
```

### Setup
- Clone down this repo

```
git clone git@github.com:jude-lawson/quantified-self-phoenix.git
```

- Install dependencies: `mix deps.get`
- Run `mix ecto.create` & `mix ecto.migrate` to setup your databases.
  - If you get an error about a missing role `postgres` - run the following command in your terminal to setup that role:
  ```shell
  $ psql
  CREATE USER postgres;
  ALTER USER postgres PASSWORD 'postgres';
  ALTER USER postgres WITH SUPERUSER;
  \q
  ```
- Please be sure to run `mix ecto.create` && `mix ecto.migrate` after resolving these errors.
- Run all tests to ensure that they are passing: `mix test`
- Run the app locally to make sure there are no server-side errors: `mix phx.server`

### Contributing

We are accepting contributions!
Please be sure to do the following when contributing:

- Fork this repository.
- Clone it down and follow the setup steps above.
- When submitting a PR, use the PR template that automatically populates in the PR field.
- Please be sure to reference the issue that you are addressing. If there is not an existing issue, please create one.
- We will do our best to provide code reviews, please make any required changes and re-push to the branch with the open PR. No need to make a new PR.
