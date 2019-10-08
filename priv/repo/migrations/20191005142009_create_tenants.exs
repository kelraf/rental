defmodule Rental.Repo.Migrations.CreateTenants do
  use Ecto.Migration

  def change do
    create table(:tenants) do
	  add :name, :string	
      add :email, :string
      add :phone, :string
      add :landlord_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end
end
