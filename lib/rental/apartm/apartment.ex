defmodule Rental.Apartm.Apartment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rental.Repo
  alias Rental.Accounts.User

  schema "apartments" do
    field :location, :string
    field :name, :string

    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(apartment = %__MODULE__{}, attrs) do
    apartment
    |> cast(attrs, [:name, :location, :user_id])
    |> validate_required([:name, :location, :user_id])
  end

end
