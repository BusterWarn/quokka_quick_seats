defmodule Mix.Tasks.DeleteAllSeats do
  use Mix.Task
  alias QuokkaQuickSeats.Repo
  alias QuokkaQuickSeats.SeatSchema

  @shortdoc "Deletes all seats from the database. Also creates a backup."

  def run(_args) do
    # Ensure the application and its dependencies are started
    {:ok, _started_apps} = Application.ensure_all_started(:quokka_quick_seats)

    count = Repo.aggregate(SeatSchema, :count, :id)
    IO.puts("There are currently #{count} seats in the database.")
    confirm_and_delete()
  end

  defp confirm_and_delete do
    IO.puts("Are you sure you want to delete all seats? (Y/N)")

    case IO.gets("") |> String.trim() |> String.upcase() do
      "Y" ->
        # Create a backup before deleting.
        Mix.Task.run("save_seats_to_json", [])

        count = Repo.delete_all(SeatSchema)
        IO.puts("Deleted #{inspect(count)} seats.")

      _ ->
        IO.puts("Operation cancelled.")
    end
  end
end
