defmodule FintrackexWeb.MovementControllerTest do
  use FintrackexWeb.ConnCase

  import Fintrackex.RegistryFixtures

  alias Fintrackex.Registry.Movement

  @create_attrs %{
    amount: 120.5,
    origin: "some origin",
    title: "some title",
    type: "some type"
  }
  @update_attrs %{
    amount: 456.7,
    origin: "some updated origin",
    title: "some updated title",
    type: "some updated type"
  }
  @invalid_attrs %{amount: nil, origin: nil, title: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all movements", %{conn: conn} do
      conn = get(conn, Routes.movement_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create movement" do
    test "renders movement when data is valid", %{conn: conn} do
      conn = post(conn, Routes.movement_path(conn, :create), movement: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.movement_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => 120.5,
               "origin" => "some origin",
               "title" => "some title",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.movement_path(conn, :create), movement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update movement" do
    setup [:create_movement]

    test "renders movement when data is valid", %{conn: conn, movement: %Movement{id: id} = movement} do
      conn = put(conn, Routes.movement_path(conn, :update, movement), movement: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.movement_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => 456.7,
               "origin" => "some updated origin",
               "title" => "some updated title",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, movement: movement} do
      conn = put(conn, Routes.movement_path(conn, :update, movement), movement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete movement" do
    setup [:create_movement]

    test "deletes chosen movement", %{conn: conn, movement: movement} do
      conn = delete(conn, Routes.movement_path(conn, :delete, movement))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.movement_path(conn, :show, movement))
      end
    end
  end

  defp create_movement(_) do
    movement = movement_fixture()
    %{movement: movement}
  end
end
