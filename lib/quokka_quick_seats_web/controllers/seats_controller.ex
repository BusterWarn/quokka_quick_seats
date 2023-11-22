defmodule QuokkaQuickSeatsWeb.SeatsController do
  @moduledoc """

  """
  use QuokkaQuickSeatsWeb, :controller

  def get_all_seats(connection, %{"key" => value}) do
    IO.puts("get_all_seats")
    text(connection, value)
  end
  def get_all_seats(connection, _) do
    IO.puts("get_all_seats")
    text(connection, "no param")
  end

  def add_seat(connection, _) do
    IO.puts("book_seat")
    text(connection, "no param")
  end
end
