defmodule RentalWeb.ApartmentView do
  use RentalWeb, :view
  alias RentalWeb.ApartmentView

  def render("index.json", %{apartments: apartments}) do
    %{data: render_many(apartments, ApartmentView, "apartment.json")}
  end
 
  def render("show.json", %{apartment: apartment}) do
    %{data: render_one(apartment, ApartmentView, "apartment.json")}
  end

  def render("apartment.json", %{apartment: apartment}) do
    %{id: apartment.id,
      name: apartment.name,
      location: apartment.location}
  end

  def render("404.json", %{error: message}) do
    %{
      error: message
    }
  end
end
