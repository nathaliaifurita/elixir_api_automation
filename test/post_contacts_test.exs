defmodule ApiAutomation.PostContactsTest do
  use ExUnit.Case
  doctest ApiAutomation

  describe "POST /contacts" do
    test "returns a created contact" do
      body = %{
        "name" => Faker.StarWars.character(),
        "last_name" => Faker.StarWars.planet(),
        "email" => Faker.Internet.email(),
        "age" => Faker.random_between(1, 99),
        "phone" => Faker.Phone.EnUs.phone(),
        "address" => Faker.StarWars.planet() <> " Street",
        "state" => Faker.StarWars.planet(),
        "city" => Faker.StarWars.planet()
      }

      headers = %{
        "Content-Type" => "application/json",
        "Accept" => "application/vnd.tasksmanager.v2"
      }

      {:ok, %{body: _response, status_code: 201}} =
        HTTPoison.post(
          "https://api-de-tarefas.herokuapp.com/contacts",
          Jason.encode!(body),
          headers
        )
    end

    test "returns an invalid email" do
      body = %{
        "name" => Faker.StarWars.character(),
        "last_name" => Faker.StarWars.planet(),
        "email" => "test",
        "age" => Faker.random_between(1, 99),
        "phone" => Faker.Phone.EnUs.phone(),
        "address" => Faker.StarWars.planet() <> " Street",
        "state" => Faker.StarWars.planet(),
        "city" => Faker.StarWars.planet()
      }

      headers = %{
        "Content-Type" => "application/json",
        "Accept" => "application/vnd.tasksmanager.v2"
      }

      {:ok, %{body: response, status_code: 422}} =
        HTTPoison.post(
          "https://api-de-tarefas.herokuapp.com/contacts",
          Jason.encode!(body),
          headers
        )

      %{"errors" => errors} = Jason.decode!(response)

      Enum.map(errors, fn _contact ->
        assert %{"email" => "não é válido"}
      end)
    end

    test "returns an error for blank email" do
      body = %{
        "name" => Faker.StarWars.character(),
        "last_name" => Faker.StarWars.planet(),
        "email" => "",
        "age" => Faker.random_between(1, 99),
        "phone" => Faker.Phone.EnUs.phone(),
        "address" => Faker.StarWars.planet() <> " Street",
        "state" => Faker.StarWars.planet(),
        "city" => Faker.StarWars.planet()
      }

      headers = %{
        "Content-Type" => "application/json",
        "Accept" => "application/vnd.tasksmanager.v2"
      }

      {:ok, %{body: response, status_code: 422}} =
        HTTPoison.post(
          "https://api-de-tarefas.herokuapp.com/contacts",
          Jason.encode!(body),
          headers
        )

      %{"errors" => errors} = Jason.decode!(response)

      Enum.map(errors, fn _contact ->
        assert %{"email" => "não pode ficar em branco"}
      end)
    end

    test "returns an error for an already used email" do
      body = %{
        "name" => Faker.StarWars.character(),
        "last_name" => Faker.StarWars.planet(),
        "email" => "nat@gmail.com",
        "age" => Faker.random_between(1, 99),
        "phone" => Faker.Phone.EnUs.phone(),
        "address" => Faker.StarWars.planet() <> " Street",
        "state" => Faker.StarWars.planet(),
        "city" => Faker.StarWars.planet()
      }

      headers = %{
        "Content-Type" => "application/json",
        "Accept" => "application/vnd.tasksmanager.v2"
      }

      {:ok, %{body: response, status_code: 422}} =
        HTTPoison.post(
          "https://api-de-tarefas.herokuapp.com/contacts",
          Jason.encode!(body),
          headers
        )

      %{"errors" => errors} = Jason.decode!(response)

      Enum.map(errors, fn _contact ->
        assert %{"email" => "já está em usoo"}
      end)
    end
  end
end
