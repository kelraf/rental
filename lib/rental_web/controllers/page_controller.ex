defmodule RentalWeb.PageController do
  use RentalWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
