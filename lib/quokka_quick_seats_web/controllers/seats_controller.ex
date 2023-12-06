defmodule QuokkaQuickSeatsWeb.SeatsController do
  @moduledoc """
  
  """
  use QuokkaQuickSeatsWeb, :controller

  alias QuokkaQuickSeats.DatabaseManager

  def get_all_seats(connection, %{"key" => value}) do
    IO.puts("get_all_seats")
    text(connection, value)
  end

  def get_all_seats(connection, _) do
    IO.puts("get_all_seats")
    json(connection, DatabaseManager.get_all_seats())
  end

  def add_seat(conn, %{"seat_id" => seat_id}) do
    case DatabaseManager.create_seat(seat_id) do
      {:ok, seat} ->
        json(conn, seat)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(changeset)
    end
  end
end
