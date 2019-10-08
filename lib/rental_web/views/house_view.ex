defmodule RentalWeb.HouseView do
  use RentalWeb, :view
  alias RentalWeb.HouseView

  def render("index.json", %{houses: houses}) do
    %{data: render_many(houses, HouseView, "house.json")}
  end

  def render("show.json", %{house: house}) do
    %{data: render_one(house, HouseView, "house.json")}
  end

  def render("house.json", %{house: house}) do
    %{id: house.id,
      apartment_id: house.apartment_id,
      tenant_id: house.tenant_id,
      status: house.status,
      rent: house.rent}
  end
end
