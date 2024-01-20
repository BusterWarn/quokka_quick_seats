defmodule QuokkaQuickSeatsWeb.BookingChannelTest do
  use QuokkaQuickSeatsWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      QuokkaQuickSeatsWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(QuokkaQuickSeatsWeb.BookingChannel, "booking:0")

    %{socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "book_seat", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to booking:lobby", %{socket: socket} do
    push(socket, "shout", %{"hello" => "all"})
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end
end
