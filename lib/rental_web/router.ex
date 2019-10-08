defmodule RentalWeb.Router do
  use RentalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RentalWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", RentalWeb do
    pipe_through :api

    # Users Routes
    resources "/users", UserController

    # Tenants
    resources "/tenants", TenantController

    # Apartment Routes
    resources "/apartments", ApartmentController
    get "/apartments/user/:user_id", ApartmentController, :my_apartments


    # Houses Routes
    resources "/houses", HouseController
  end
end
