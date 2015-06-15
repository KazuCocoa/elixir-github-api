defmodule Github.Router do
  use Trot.Router

  # @path_root "api"

  get "/" do
    {201, %{"hyper": "social"} }
  end

  get "/a" do
    {201, %{"hyper": "social"} }
  end

  import_routes Trot.NotFound
end
