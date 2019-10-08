defmodule RentalWeb.ApartmentControllerTest do
  use RentalWeb.ConnCase

  alias Rental.Apartm
  alias Rental.Apartm.Apartment

  @create_attrs %{location: "some location", name: "some name"}
  @update_attrs %{location: "some updated location", name: "some updated name"}
  @invalid_attrs %{location: nil, name: nil}

  def fixture(:apartment) do
    {:ok, apartment} = Apartm.create_apartment(@create_attrs)
    apartment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all apartments", %{conn: conn} do
      conn = get conn, apartment_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create apartment" do
    test "renders apartment when data is valid", %{conn: conn} do
      conn = post conn, apartment_path(conn, :create), apartment: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, apartment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "location" => "some location",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, apartment_path(conn, :create), apartment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update apartment" do
    setup [:create_apartment]

    test "renders apartment when data is valid", %{conn: conn, apartment: %Apartment{id: id} = apartment} do
      conn = put conn, apartment_path(conn, :update, apartment), apartment: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, apartment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "location" => "some updated location",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, apartment: apartment} do
      conn = put conn, apartment_path(conn, :update, apartment), apartment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete apartment" do
    setup [:create_apartment]

    test "deletes chosen apartment", %{conn: conn, apartment: apartment} do
      conn = delete conn, apartment_path(conn, :delete, apartment)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, apartment_path(conn, :show, apartment)
      end
    end
  end

  defp create_apartment(_) do
    apartment = fixture(:apartment)
    {:ok, apartment: apartment}
  end
end
