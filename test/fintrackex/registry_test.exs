defmodule Fintrackex.RegistryTest do
  use Fintrackex.DataCase

  alias Fintrackex.Registry

  describe "movements" do
    alias Fintrackex.Registry.Movement

    import Fintrackex.RegistryFixtures

    @invalid_attrs %{amount: nil, origin: nil, title: nil, type: nil}

    test "list_movements/0 returns all movements" do
      movement = movement_fixture()
      assert Registry.list_movements() == [movement]
    end

    test "get_movement!/1 returns the movement with given id" do
      movement = movement_fixture()
      assert Registry.get_movement!(movement.id) == movement
    end

    test "create_movement/1 with valid data creates a movement" do
      valid_attrs = %{amount: 120.5, origin: "some origin", title: "some title", type: "some type"}

      assert {:ok, %Movement{} = movement} = Registry.create_movement(valid_attrs)
      assert movement.amount == 120.5
      assert movement.origin == "some origin"
      assert movement.title == "some title"
      assert movement.type == "some type"
    end

    test "create_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registry.create_movement(@invalid_attrs)
    end

    test "update_movement/2 with valid data updates the movement" do
      movement = movement_fixture()
      update_attrs = %{amount: 456.7, origin: "some updated origin", title: "some updated title", type: "some updated type"}

      assert {:ok, %Movement{} = movement} = Registry.update_movement(movement, update_attrs)
      assert movement.amount == 456.7
      assert movement.origin == "some updated origin"
      assert movement.title == "some updated title"
      assert movement.type == "some updated type"
    end

    test "update_movement/2 with invalid data returns error changeset" do
      movement = movement_fixture()
      assert {:error, %Ecto.Changeset{}} = Registry.update_movement(movement, @invalid_attrs)
      assert movement == Registry.get_movement!(movement.id)
    end

    test "delete_movement/1 deletes the movement" do
      movement = movement_fixture()
      assert {:ok, %Movement{}} = Registry.delete_movement(movement)
      assert_raise Ecto.NoResultsError, fn -> Registry.get_movement!(movement.id) end
    end

    test "change_movement/1 returns a movement changeset" do
      movement = movement_fixture()
      assert %Ecto.Changeset{} = Registry.change_movement(movement)
    end
  end
end
