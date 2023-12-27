defmodule QuokkaQuickSeatsWeb.SeatsController do
  @moduledoc """
  
  """
  use QuokkaQuickSeatsWeb, :controller

  alias QuokkaQuickSeats.DatabaseManager

  defmacro is_valid_input_string(value) do
    quote do
      is_binary(unquote(value)) and unquote(value) != ""
    end
  end

  def valid_swedish_phone_number?(phone_number) do
    Regex.match?(~r/^(?:\+46|0046|0)\d{6,10}$/, phone_number)
  end

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

  def book_seat(conn, %{
        "seat_id" => seat_id,
        "full_name" => full_name,
        "phone_number" => phone_number
      })
      when is_valid_input_string(seat_id) and
             is_valid_input_string(full_name) and
             is_valid_input_string(phone_number) do
    cond do
      not valid_swedish_phone_number?(phone_number) ->
        conn
        # Set the status code to 400
        |> put_status(:bad_request)
        |> json(%{error: "Not a valid phone number: #{inspect(phone_number)}"})

      is_seat_free(seat_id) ->
        DatabaseManager.unbook_by_name(full_name)

        case DatabaseManager.book_seat(seat_id, full_name, phone_number) do
          {:ok, seat} ->
            json(conn, seat)

          {:error, reason} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: reason})
        end

      true ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Seat #{seat_id} already booked"})
    end
  end

  def book_seat(conn, input) do
    conn
    # Set the status code to 400
    |> put_status(:bad_request)
    |> json(%{error: "Invalid Input: #{inspect(input)}"})
  end

  defp is_seat_free(seat_id) when is_binary(seat_id) do
    case DatabaseManager.get_seat(seat_id) do
      nil -> false
      seat -> not seat.is_booked
    end
  end
end
