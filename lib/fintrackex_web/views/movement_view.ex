defmodule FintrackexWeb.MovementView do
  use FintrackexWeb, :view
  alias FintrackexWeb.MovementView

  def render("index.json", %{movements: movements}) do
    %{data: render_many(movements, MovementView, "movement.json")}
  end

  def render("show.json", %{movement: movement}) do
    %{data: render_one(movement, MovementView, "movement.json")}
  end

  def render("movement.json", %{movement: movement}) do
    %{
      id: movement.id,
      title: movement.title,
      amount: movement.amount,
      origin: movement.origin,
      type: movement.type,
      move_date: movement.move_date
    }
  end

  def render("error.json", %{error: error}) do
    %{ error: error }
  end
end
