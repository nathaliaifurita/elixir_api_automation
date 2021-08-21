defmodule ApiAutomation.GetContactsTest do
  use ExUnit.Case
  doctest ApiAutomation

  describe "GET /contacts" do
    test "returns a list of contacts" do
      {:ok, %{body: response, status_code: 200}} =
        HTTPoison.get("https://api-de-tarefas.herokuapp.com/contacts")

      %{"data" => data} = Jason.decode!(response)

      Enum.each(data, fn contact ->
        assert %{
                 "attributes" => %{
                   "address" => _,
                   "age" => _,
                   "city" => _,
                   "email" => _,
                   "last-name" => _,
                   "name" => _,
                   "phone" => _,
                   "state" => _
                 },
                 "id" => _,
                 "type" => _
               } = contact
      end)
    end
  end
end
