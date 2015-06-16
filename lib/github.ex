defmodule Github do
  use HTTPoison.Base

  defmodule Config do
    defstruct api: "https://api.github.com",
              token: "your token"
  end

  defmodule GithubResponseError do
    defexception message: "response error"
  end

  def get_top do
    url = "/"
    headers = []
    case Github.get(url, headers) do
      {:ok, response} ->
        response.body
      {:error, reason} ->
        raise [:error, reason]
    end
  end

  def get_user_info do
    url = "/user"
    headers = [{"Authorization", " token #{%Github.Config{}.token}"}]

    case Github.get(url, headers) do
      {:ok, response} ->
        response.body
      {:error, reason} ->
        raise [:error, reason]
    end
  end

  def get_milestones(repo, params \\ %{}) do
    url = "/repos/#{repo}/milestones"
    headers = [{"Authorization", " token #{%Github.Config{}.token}"}]

    case Github.get(url, headers, params: params) do
      {:ok, response} ->
        response.body
      {:error, reason} ->
        raise [:error, reason]
    end
  end

  defp process_url(url) do
    %Github.Config{}.api <> url
  end

  # Overriding
  defp process_response_body(body) do
    body
    |> Poison.decode!
  #  |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

end
