defmodule Rental.Repo.Migrations.AlterTenantsTableAddUniqueEmail do
  use Ecto.Migration

  def change do
   create unique_index(:tenants, [:email])
  end
end
