defmodule FintrackexWeb.PageController do
  use FintrackexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
