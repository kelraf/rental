defmodule RentalWeb.UserController do
  use RentalWeb, :controller

  alias Rental.Accounts
  alias Rental.Accounts.User

  action_fallback RentalWeb.FallbackController

  def index(conn, _params) do
    conn 
    |> IO.inspect
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end


  # Custom Endpoints Methods
  # User login
  def login(conn, %{"infor" => infor}) do

    case Accounts.login(infor) do
      {:ok, messase} ->
        conn
        |> json(%{messase: messase})
      {:error, error} -> 
        conn
        |> json(%{error: error})
    end
    
  end

end
