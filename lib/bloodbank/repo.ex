defmodule Bloodbank.Repo do
  use Ecto.Repo,
    otp_app: :bloodbank,
    adapter: Ecto.Adapters.Postgres
end
