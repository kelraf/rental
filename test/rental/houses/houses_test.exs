defmodule Rental.HousesTest do
  use Rental.DataCase

  alias Rental.Houses

  describe "houses" do
    alias Rental.Houses.House

    @valid_attrs %{apartment_id: 42, rent: 42, status: "some status", tenant_id: 42}
    @update_attrs %{apartment_id: 43, rent: 43, status: "some updated status", tenant_id: 43}
    @invalid_attrs %{apartment_id: nil, rent: nil, status: nil, tenant_id: nil}

    def house_fixture(attrs \\ %{}) do
      {:ok, house} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Houses.create_house()

      house
    end

    test "list_houses/0 returns all houses" do
      house = house_fixture()
      assert Houses.list_houses() == [house]
    end

    test "get_house!/1 returns the house with given id" do
      house = house_fixture()
      assert Houses.get_house!(house.id) == house
    end

    test "create_house/1 with valid data creates a house" do
      assert {:ok, %House{} = house} = Houses.create_house(@valid_attrs)
      assert house.apartment_id == 42
      assert house.rent == 42
      assert house.status == "some status"
      assert house.tenant_id == 42
    end

    test "create_house/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Houses.create_house(@invalid_attrs)
    end

    test "update_house/2 with valid data updates the house" do
      house = house_fixture()
      assert {:ok, house} = Houses.update_house(house, @update_attrs)
      assert %House{} = house
      assert house.apartment_id == 43
      assert house.rent == 43
      assert house.status == "some updated status"
      assert house.tenant_id == 43
    end

    test "update_house/2 with invalid data returns error changeset" do
      house = house_fixture()
      assert {:error, %Ecto.Changeset{}} = Houses.update_house(house, @invalid_attrs)
      assert house == Houses.get_house!(house.id)
    end

    test "delete_house/1 deletes the house" do
      house = house_fixture()
      assert {:ok, %House{}} = Houses.delete_house(house)
      assert_raise Ecto.NoResultsError, fn -> Houses.get_house!(house.id) end
    end

    test "change_house/1 returns a house changeset" do
      house = house_fixture()
      assert %Ecto.Changeset{} = Houses.change_house(house)
    end
  end
end
