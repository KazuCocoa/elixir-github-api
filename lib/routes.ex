defmodule Github.Router do
  use Trot.Router

  # @path_root "api"

  get "/", do: 200

  import_routes Trot.NotFound
end
