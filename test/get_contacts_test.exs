defmodule ApiAutomation.GetContactsTest do
  use ExUnit.Case
  doctest ApiAutomation

  describe "GET /contacts" do
    test "returns a list of contacts" do
      {:ok, %{body: response, status_code: 200}} =
        HTTPoison.get("https://api-de-tarefas.herokuapp.com/contacts")

      # comparação de valores entre a resposta do HTTPOison e o {:ok, ...}
      # comparando os padrões em um mapa pra pegar o body e colocar na variavel response
      # comparação do status_code que deve ser igual a 200
      %{"data" => data} = Jason.decode!(response)
      # O decode transforma os parametros do mapa numa string
      # Transformando o Jason num mapa e comparando os padrões de data pra jogar na variavel data
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

      # Pra cada "data" que tiver no response, 
      # eu testo a estrutura do mapa de resposta do contact,
      # usando a função anonima pra comparar os parametros de 
      # dentro do mapa
    end
  end
end
