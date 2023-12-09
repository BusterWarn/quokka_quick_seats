# import Phoenix.LiveView.embed_templates()

defmodule QuokkaQuickSeatsWeb.QuokkaQuickSeatsHTML do
  # use Phoenix.Component
  # use Phoenix.View,
  #   root: "lib/quokka_quick_seats_web/templates",
  #   namespace: QuokkaQuickSeatsWeb

  use QuokkaQuickSeatsWeb, :html

  embed_templates "quokka_quick_seats_html/*"
end
