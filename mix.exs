defmodule Github.Mixfile do
  use Mix.Project

  def project do
    [app: :github,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [
      applications: [:logger, :trot, :httpoison]
    ]
  end

  defp deps do
    [
      {:trot, "~> 0.5.2"},
      {:httpoison, "~> 0.7"}
    ]
  end
end
