defmodule Fintrackex.Repo.Migrations.MovementsAddMoveDateColumn do
  use Ecto.Migration

  def change do
    alter table("movements") do
      add :move_date, :date
    end
  end
end
