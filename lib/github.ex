defmodule Github do
  use HTTPoison.Base

  defmodule Config do
    defstruct api: "https://api.github.com",
              token: Application.get_env(:github, :github_token)
  end

  defmodule GithubResponseError do
    defexception message: "response error"
  end

  def get_top do
    url = "/"
    github_get(url)
  end

  def get_user_info do
    url = "/user"
    github_get(url)
  end

  def get_milestones(repo, params \\ %{}) do
    url = "/repos/#{repo}/milestones"
    github_get(url, params)
  end

  def get_issues(repo, params \\ %{}) do
    url = "/repos/#{repo}/issues"
    github_get(url, params)
  end

  # Overriding
  defp process_url(url) do
    %Github.Config{}.api <> url
  end

  # Overriding
  defp process_response_body(body) do
    body
    |> Poison.decode!
  #  |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  defp github_get(url, params \\ %{}) do
    headers = case %Github.Config{}.token do
      nil -> []
      "" -> []
      _ -> [{"Authorization", "token #{%Github.Config{}.token}"}]
    end

    case Github.get(url, headers, params: params) do
      {:ok, response} ->
        case response.status_code do
          200 ->
            response.body
          401 ->
            raise response.body["message"]
          403 ->
            raise response.body["message"]
          _ ->
            IO.inspect response.status_code
            response.body
        end
      {:error, reason} ->
        [:error, reason]
    end

  end

end
