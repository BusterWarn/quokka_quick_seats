defmodule QuokkaQuickSeatsWeb.QuokkaQuickSeatsLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(QuokkaQuickSeatsWeb.QuokkaQuickSeatsView, "show.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, :messenger, "Phoenix")}
  end
end
