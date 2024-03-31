defmodule Mix.Tasks.UnbookSeats do
  use Mix.Task

  alias QuokkaQuickSeats.DatabaseManager

  @shortdoc "Unbooks all seats in the database. Creates a backup before."

  def run(_args) do
    IO.puts("Are you sure you want to unbook all seats? (type 'C' to confirm)")
    confirmation = IO.gets("") |> String.trim()

    if confirmation == "C" do
      # Ensure the application and its dependencies are started
      {:ok, _started_apps} = Application.ensure_all_started(:quokka_quick_seats)

      # Create a backup
      Mix.Task.run("save_seats_to_json", [])

      DatabaseManager.unbook_all_seats()
      IO.puts("All seats unbooked")
    else
      IO.puts("Unbooking cancelled")
    end
  end
end
