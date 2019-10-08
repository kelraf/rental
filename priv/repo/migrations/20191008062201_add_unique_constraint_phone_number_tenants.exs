defmodule Rental.Repo.Migrations.AddUniqueConstraintPhoneNumberUsers do
  use Ecto.Migration

  def change do
  	create unique_index(:tenants, [:phone])
  end
end
