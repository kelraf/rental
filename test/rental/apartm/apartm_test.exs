defmodule Rental.ApartmTest do
  use Rental.DataCase

  alias Rental.Apartm

  describe "apartments" do
    alias Rental.Apartm.Apartment

    @valid_attrs %{location: "some location", name: "some name"}
    @update_attrs %{location: "some updated location", name: "some updated name"}
    @invalid_attrs %{location: nil, name: nil}

    def apartment_fixture(attrs \\ %{}) do
      {:ok, apartment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Apartm.create_apartment()

      apartment
    end

    test "list_apartments/0 returns all apartments" do
      apartment = apartment_fixture()
      assert Apartm.list_apartments() == [apartment]
    end

    test "get_apartment!/1 returns the apartment with given id" do
      apartment = apartment_fixture()
      assert Apartm.get_apartment!(apartment.id) == apartment
    end

    test "create_apartment/1 with valid data creates a apartment" do
      assert {:ok, %Apartment{} = apartment} = Apartm.create_apartment(@valid_attrs)
      assert apartment.location == "some location"
      assert apartment.name == "some name"
    end

    test "create_apartment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apartm.create_apartment(@invalid_attrs)
    end

    test "update_apartment/2 with valid data updates the apartment" do
      apartment = apartment_fixture()
      assert {:ok, apartment} = Apartm.update_apartment(apartment, @update_attrs)
      assert %Apartment{} = apartment
      assert apartment.location == "some updated location"
      assert apartment.name == "some updated name"
    end

    test "update_apartment/2 with invalid data returns error changeset" do
      apartment = apartment_fixture()
      assert {:error, %Ecto.Changeset{}} = Apartm.update_apartment(apartment, @invalid_attrs)
      assert apartment == Apartm.get_apartment!(apartment.id)
    end

    test "delete_apartment/1 deletes the apartment" do
      apartment = apartment_fixture()
      assert {:ok, %Apartment{}} = Apartm.delete_apartment(apartment)
      assert_raise Ecto.NoResultsError, fn -> Apartm.get_apartment!(apartment.id) end
    end

    test "change_apartment/1 returns a apartment changeset" do
      apartment = apartment_fixture()
      assert %Ecto.Changeset{} = Apartm.change_apartment(apartment)
    end
  end
end
