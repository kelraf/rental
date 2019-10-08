defmodule Rental.Houses.House do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rental.Apartm.Apartment
  # alias Rental.Accounts.User
  alias Rental.Tenants.Tenant


  schema "houses" do
    field :rent, :integer
    field :status, :string
    belongs_to :tenant, Tenant
    belongs_to :apartment, Apartment

    timestamps()
  end

  @doc false
  def changeset(house, attrs) do
    house
    |> cast(attrs, [:rent, :status, :apartment_id, :tenant_id])
    |> validate_required([:apartment_id, :status, :rent])
  end
end
