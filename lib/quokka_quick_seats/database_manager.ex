defmodule QuokkaQuickSeats.DatabaseManager do
  @moduledoc """
  This is a manager fo the Database
  """

  alias QuokkaQuickSeats.SeatSchema
  alias QuokkaQuickSeats.Repo

  def get_all_seats() do
    Repo.all(SeatSchema)
    # Convert each seat to a map
    |> Enum.map(&convert_seat_to_map/1)
  end

  def get_seat(seat_id) when is_binary(seat_id) do
    Repo.get_by(SeatSchema, seat_id: seat_id)
    |> convert_seat_to_map
  end

  def create_seat(seat_id) when is_binary(seat_id) do
    %SeatSchema{seat_id: seat_id}
    |> SeatSchema.changeset(%{})
    |> Repo.insert()
  end

  defp convert_seat_to_map(nil), do: nil

  defp convert_seat_to_map(seat) do
    %{
      id: seat.id,
      seat_id: seat.seat_id,
      is_booked: seat.is_booked,
      phone_number: seat.phone_number,
      full_name: seat.full_name
    }
  end
end
