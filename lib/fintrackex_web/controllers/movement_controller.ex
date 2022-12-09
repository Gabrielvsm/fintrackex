defmodule FintrackexWeb.MovementController do
  use FintrackexWeb, :controller

  alias Fintrackex.Registry
  alias Fintrackex.Registry.Movement

  action_fallback FintrackexWeb.FallbackController

  def index(conn, _params) do
    movements = Registry.list_movements()
    render(conn, "index.json", movements: movements)
  end

  def create(conn, %{"movement" => movement_params}) do
    with {:ok, %Movement{} = movement} <- Registry.create_movement(movement_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.movement_path(conn, :show, movement))
      |> render("show.json", movement: movement)
    end
  end

  def show(conn, %{"id" => id}) do
    case Registry.get_movement(id) do
      nil -> render(conn, "error.json", error: "Movement not found!")
      movement -> render(conn, "show.json", movement: movement)
    end
  end

  def update(conn, %{"id" => id, "movement" => movement_params}) do
    movement = Registry.get_movement!(id)

    with {:ok, %Movement{} = movement} <- Registry.update_movement(movement, movement_params) do
      render(conn, "show.json", movement: movement)
    end
  end

  def delete(conn, %{"id" => id}) do
    movement = Registry.get_movement!(id)

    with {:ok, %Movement{}} <- Registry.delete_movement(movement) do
      send_resp(conn, :no_content, "")
    end
  end
end
