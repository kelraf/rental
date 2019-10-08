defmodule Rental.Repo.Migrations.CreateHouses do
  use Ecto.Migration

  def change do
    create table(:houses) do
      add :status, :string
      add :rent, :integer
      add :apartment_id, references(:apartments, on_delete: :delete_all)
      add :tenant_id, references(:tenants)

      timestamps()
    end

  end
end
