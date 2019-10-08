defmodule Rental.Repo.Migrations.CreateApartments do
  use Ecto.Migration

  def change do
    create table(:apartments) do
      add :name, :string
      add :location, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end

end
