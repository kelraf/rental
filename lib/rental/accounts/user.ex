defmodule Rental.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :confirm_password, :string
    field :email, :string
    field :password, :string
    field :username, :string
    field :role, :string

    timestamps()
  end
 
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :confirm_password, :role])
    |> validate_required([:username, :email, :password, :confirm_password, :role])
    |> validate_passwords_len()
    |> validate_username_len()
    |> password_hash()
    |> unique_constraint(:username, message: "Username Provided already exists")
    |> unique_constraint(:email, message: "Email You Provided Already Exists")

  end


  # A method to validate Username
  def validate_username(changeset) do

  end

  defp validate_username_len(changeset) do

    case get_field(changeset, :username) do
      nil -> changeset
      value -> 
        if String.length(value) < 6 or String.length(value) > 15 do
          add_error(changeset, :username, "Username must be between 6 and 15 characters")
        else 
          changeset
        end
        
    end

  end

  defp validate_passwords_len(changeset) do

    password = get_field(changeset, :password)
    confirm_password = get_field(changeset, :confirm_password)

    cond do
      String.length(password) < 6 or String.length(password) > 15 -> 
        add_error(changeset, :password, "password must be between 6 and 15 characters")
      confirm_password !== password -> 
        add_error(changeset, :confirm_password, "Your passwords must match")
      true -> 
        changeset 
    end
  end

  def password_hash(changeset) do
    password = get_field(changeset, :password)
    confirm_password = get_field(changeset, :confirm_password)
    put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(password))
    |> put_change(:confirm_password, Comeonin.Bcrypt.hashpwsalt(confirm_password))
  end

end
