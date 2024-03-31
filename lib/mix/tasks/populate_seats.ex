defmodule Mix.Tasks.PopulateSeats do
  use Mix.Task

  alias QuokkaQuickSeats.DatabaseManager

  @shortdoc "Populates the database with seats from a list or file."
  def run(args) do
    # Ensure the application and its dependencies are started
    {:ok, _started_apps} = Application.ensure_all_started(:quokka_quick_seats)

    # Create a backup
    Mix.Task.run("save_seats_to_json", [])

    seats = parse_args(args)
    Enum.each(seats, &DatabaseManager.create_seat/1)
    IO.puts("Database populated with #{Enum.count(seats)} seats.")
  end

  defp parse_args([file_path]) when is_binary(file_path) do
    file_path
    |> File.stream!()
    |> Enum.map(&String.trim/1)
  end

  defp parse_args(_), do: Mix.raise("Usage: mix populate_seats <file_path>")
end
