defmodule Rental.Tenants.Tenant do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Rental.Repo


  schema "tenants" do
    field :name, :string
    field :email, :string
    field :phone, :string
    belongs_to :landlord, User

    timestamps()
  end

  @doc false
  def changeset(tenant, attrs) do
    tenant
    |> cast(attrs, [:name, :email, :phone, :landlord_id])
    |> validate_required([:name, :email, :phone, :landlord_id])
    |> unique_constraint(:email, message: "The Email You Provided Already Exists")
    |> unique_constraint(:phone, message: "The Phone Number You Provided Already Exists")
  end

end
