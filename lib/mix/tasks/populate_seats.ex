defmodule Mix.Tasks.PopulateSeats do
  use Mix.Task
  alias QuokkaQuickSeats.DatabaseManager

  @shortdoc "Populates the database with seats from a list in a TXT file or JSON file. Deletes and backups before."
  def run(args) do
    {:ok, _started_apps} = Application.ensure_all_started(:quokka_quick_seats)

    # Delete all seats and create a backup before
    Mix.Task.run("delete_all_seats", [])

    seats = parse_args(args)
    Enum.each(seats, &DatabaseManager.create_seat/1)
    IO.puts("Database populated with #{Enum.count(seats)} seats.")
  end

  defp parse_args([file_path]) when is_binary(file_path) do
    case String.ends_with?(file_path, ".json") do
      true -> parse_json(file_path)
      false -> parse_text(file_path)
    end
  end

  defp parse_args(_), do: Mix.raise("Usage: mix populate_seats <file_path>")

  defp parse_text(file_path) do
    file_path
    |> File.stream!()
    |> Enum.map(&String.trim/1)
  end

  defp parse_json(file_path) do
    file_path
    |> File.read!()
    |> Jason.decode!()
    |> Enum.map(fn %{"seat_id" => seat_id} -> seat_id end)
  end
end
