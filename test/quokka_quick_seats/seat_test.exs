defmodule QuokkaQuickSeats.SeatTest do
  use QuokkaQuickSeats.DataCase

  alias QuokkaQuickSeats.SeatSchema

  describe "seats" do
    test "creates and retrieves a seat" do
      seat_attrs = %{seat_id: "A1", is_booked: false}
      {:ok, seat} = SeatSchema.changeset(%SeatSchema{}, seat_attrs) |> QuokkaQuickSeats.Repo.insert()

      assert seat.seat_id == "A1"
      assert seat.is_booked == false
      assert seat.phone_number == nil
      assert seat.full_name == nil
    end
  end
end
