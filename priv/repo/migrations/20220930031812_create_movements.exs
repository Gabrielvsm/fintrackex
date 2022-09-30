defmodule Fintrackex.Repo.Migrations.CreateMovements do
  use Ecto.Migration

  def change do
    create table(:movements) do
      add :title, :string, null: false
      add :amount, :float, null: false
      add :origin, :string
      add :type, :string, null: false

      timestamps()
    end
  end
end
