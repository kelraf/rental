defmodule RentalWeb.ApartmentController do
  use RentalWeb, :controller

  alias Rental.Apartm
  alias Rental.Apartm.Apartment 

  action_fallback RentalWeb.FallbackController

  def index(conn, _params) do
    apartments = Apartm.list_apartments()
    render(conn, "index.json", apartments: apartments)
  end

  def create(conn, %{"apartment" => apartment_params}) do
    with {:ok, %Apartment{} = apartment} <- Apartm.create_apartment(apartment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", apartment_path(conn, :show, apartment))
      |> render("show.json", apartment: apartment)
    end
  end

  def show(conn, %{"id" => id}) do
    apartment = Apartm.get_apartment!(id)
    render(conn, "show.json", apartment: apartment)
  end

  def update(conn, %{"id" => id, "apartment" => apartment_params}) do
    apartment = Apartm.get_apartment!(id)

    with {:ok, %Apartment{} = apartment} <- Apartm.update_apartment(apartment, apartment_params) do
      render(conn, "show.json", apartment: apartment)
    end
  end

  def delete(conn, %{"id" => id}) do
    apartment = Apartm.get_apartment!(id)
    with {:ok, %Apartment{}} <- Apartm.delete_apartment(apartment) do
      send_resp(conn, :no_content, "")
    end
  end

  # Custom Endpoints
  def my_apartments(conn, %{"user_id" => user_id}) do
    
    case Apartm.my_apartments(user_id) do
      {:ok, apartments} -> 
        render(conn, "index.json", apartments: apartments)
      {:error, message} ->
        render(conn, "404.json", error: message)
    end

  end
end
