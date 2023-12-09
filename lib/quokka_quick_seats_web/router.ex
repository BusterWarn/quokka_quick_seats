import Phoenix.LiveView.Router

defmodule QuokkaQuickSeatsWeb.Router do
  alias QuokkaQuickSeatsWeb.SeatsController
  use QuokkaQuickSeatsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    # plug :put_root_layout, html: {HelloWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/api" do
    pipe_through :api

    get "/seats", SeatsController, :get_all_seats
    post "/seats", SeatsController, :add_seat
  end

  scope "/" do
    pipe_through :browser
    live "/quokka_quick_seats_show", QuokkaQuickSeatsLive
    # get "/index", SeatsController, :index
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:quokka_quick_seats, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: QuokkaQuickSeatsWeb.Telemetry
    end
  end
end
