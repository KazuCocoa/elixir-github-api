defmodule Github do
  use HTTPoison.Base

  defmodule Config do
    defstruct api: "https://api.github.com",
              token: "set token"
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

  @doc """
   [avatar_url: "https://avatars.githubusercontent.com/u/5511591?v=3", bio: nil,
   blog: "http://kazucocoa.wordpress.com", collaborators: 2,
   company: "Cookpad(see: kazu-matsu)", created_at: "2013-09-22T07:56:17Z",
   disk_usage: 7351, email: "matsuo@cookpad.com",
   events_url: "https://api.github.com/users/KazuCocoa/events{/privacy}",
   followers: 6,
   followers_url: "https://api.github.com/users/KazuCocoa/followers",
   following: 3,
   following_url: "https://api.github.com/users/KazuCocoa/following{/other_user}",
   gists_url: "https://api.github.com/users/KazuCocoa/gists{/gist_id}",
   gravatar_id: "", hireable: false, html_url: "https://github.com/KazuCocoa",
   id: 5511591, location: "", login: "KazuCocoa", name: "Kazuaki MATSUO",
   organizations_url: "https://api.github.com/users/KazuCocoa/orgs",
   owned_private_repos: 3,
   plan: %{"collaborators" => 0, "name" => "micro", "private_repos" => 5,
     "space" => 976562499}, private_gists: 23, public_gists: 1, public_repos: 48,
   received_events_url: "https://api.github.com/users/KazuCocoa/received_events",
   repos_url: "https://api.github.com/users/KazuCocoa/repos", site_admin: false,
   starred_url: "https://api.github.com/users/KazuCocoa/starred{/owner}{/repo}",
   subscriptions_url: "https://api.github.com/users/KazuCocoa/subscriptions",
   total_private_repos: 3, type: "User", updated_at: "2015-06-15T08:50:23Z",
   url: "https://api.github.com/users/KazuCocoa"]
  """
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



  defp process_url(url) do
    %Github.Config{}.api <> url
  end

  # Overriding
  defp process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

end
