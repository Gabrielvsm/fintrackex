defmodule Fintrackex.Repo do
  use Ecto.Repo,
    otp_app: :fintrackex,
    adapter: Ecto.Adapters.SQLite3
end
