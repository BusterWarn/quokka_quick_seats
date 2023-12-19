defmodule QuokkaQuickSeatsWeb.SeatsController do
  @moduledoc """
  
  """
  use QuokkaQuickSeatsWeb, :controller

  alias QuokkaQuickSeats.DatabaseManager

  def get_all_seats(connection, _) do
    json(connection, DatabaseManager.get_all_seats())
  end

  def get_seat(conn, %{"id" => seat_id}) do
    case DatabaseManager.get_seat(seat_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Seat #{seat_id} not found"})

      seat ->
        json(conn, seat)
    end
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
