defmodule Mix.Tasks.SaveSeatsToJson do
  use Mix.Task
  alias QuokkaQuickSeats.{Repo, SeatSchema}
  @shortdoc "Saves all seats to a JSON file."

  # When a file_path is provided
  def run([file_path]) when is_binary(file_path) do
    save_seats_to_file(file_path)
  end

  # When no arguments are provided
  def run([]) do
    file_path = default_file_path()
    save_seats_to_file(file_path)
  end

  # Helper function to save seats to a file
  defp save_seats_to_file(file_path) do
    {:ok, _} = Application.ensure_all_started(:quokka_quick_seats)

    seats = Repo.all(SeatSchema) |> Enum.map(&map_seat/1)
    file_content = Jason.encode!(seats)
    File.write!(file_path, file_content)
    IO.puts("Seats saved to #{file_path}")
  end

  defp map_seat(seat) do
    %{
      seat_id: seat.seat_id,
      is_booked: seat.is_booked,
      full_name: seat.full_name,
      phone_number: seat.phone_number
    }
  end

  defp default_file_path do
    directory = "priv/data/seats_backup"
    File.mkdir_p(directory)

    timestamp =
      :os.system_time(:second)
      |> DateTime.from_unix!()
      |> DateTime.to_string()
      |> String.replace(~r/[:\s]/, "-")

    "#{directory}/seats-#{timestamp}.json"
  end
end
