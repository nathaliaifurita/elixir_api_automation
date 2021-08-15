defmodule ApiAutomation.PostContactsTest do
  use ExUnit.Case
  doctest ApiAutomation

  describe "POST /contacts" do
    test "returns a created contact" do
      body = %{
        "name" => Faker.StarWars.character(),
        "last_name" => Faker.StarWars.planet(),
        "email" => Faker.Internet.email(),
        "age" => "19",
        "phone" => Faker.Phone.EnUs.phone(),
        "address" => Faker.StarWars.planet() <> " Street",
        "state" => Faker.StarWars.planet(),
        "city" => Faker.StarWars.planet()
      }

      headers = %{
        "Content-Type" => "application/json", 
        "Accept" => "application/vnd.tasksmanager.v2"
      }

      {:ok, %{body: response, status_code: 201}} = HTTPoison.post("https://api-de-tarefas.herokuapp.com/contacts", Jason.encode!(body), headers)
      |> IO.inspect
    end
  end
end
