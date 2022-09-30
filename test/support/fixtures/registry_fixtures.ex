defmodule Fintrackex.RegistryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fintrackex.Registry` context.
  """

  @doc """
  Generate a movement.
  """
  def movement_fixture(attrs \\ %{}) do
    {:ok, movement} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        origin: "some origin",
        title: "some title",
        type: "some type"
      })
      |> Fintrackex.Registry.create_movement()

    movement
  end
end
