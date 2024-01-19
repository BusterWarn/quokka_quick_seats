defmodule QuokkaQuickSeatsWeb.BookingChannel do
  use QuokkaQuickSeatsWeb, :channel

  @impl true
  def join("booking:0", payload, socket) do
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("book_seat", payload, socket) do
    broadcast(socket, "seat_booked", payload)
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (booking:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end
end
