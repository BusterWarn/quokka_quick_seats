defmodule QuokkaQuickSeats.Repo.Migrations.CreateSeats do
  use Ecto.Migration

  def change do
    create table(:seats) do
      add :seat_id, :string, null: false
      add :is_booked, :boolean, default: false
      add :phone_number, :string
      add :full_name, :string

      timestamps()
    end
  end
end
