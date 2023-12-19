defmodule QuokkaQuickSeatsWeb.PageController do
  use QuokkaQuickSeatsWeb, :controller

  def index(conn, _params) do
    send_resp(conn, 200, File.read!("priv/static/index.html"))
  end
end
