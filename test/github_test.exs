defmodule GithubTest do
  use ExUnit.Case

  test "get_top" do
    assert Github.get_top != empty?
  end

  test "get_user_info" do
    assert Github.get_user_info != empty?
  end

  test "get_milestones" do
    params = %{state: "closed"}
    repo = "KazuCocoa/tagTestRepository"

    assert Github.get_milestones(repo, params) != empty?
  end

  defp empty? do
    nil || ""
  end
end
