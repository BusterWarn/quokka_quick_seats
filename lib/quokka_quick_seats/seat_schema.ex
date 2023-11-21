defmodule QuokkaQuickSeats.SeatSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seats" do
    field :seat_id, :string
    field :is_booked, :boolean, default: false
    field :phone_number, :string
    field :full_name, :string

    timestamps()
  end

  @doc false
  def changeset(seat, attrs) do
    seat
    |> cast(attrs, [:seat_id, :is_booked, :phone_number, :full_name])
    |> validate_required([:seat_id])
    |> validate_booking()
  end

  defp validate_booking(changeset) do
    if get_field(changeset, :is_booked) do
      changeset
      |> validate_required([:phone_number, :full_name])
    else
      changeset
    end
  end
end
