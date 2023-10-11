defmodule QuokkaQuickSeats.Repo do
  use Ecto.Repo,
    otp_app: :quokka_quick_seats,
    adapter: Ecto.Adapters.SQLite3
end
