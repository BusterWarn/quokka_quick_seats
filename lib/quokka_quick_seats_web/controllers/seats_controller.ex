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

  def add_seat(connection, _) do
    IO.puts("book_seat")
    DatabaseManager.create_seat("1")
    text(connection, "no param")
  end
end
