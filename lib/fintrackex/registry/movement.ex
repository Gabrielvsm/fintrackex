defmodule Fintrackex.Registry.Movement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movements" do
    field :amount, :float
    field :origin, :string
    field :title, :string
    field :type, Ecto.Enum, values: [:expense, :income]
    field :move_date, :date

    timestamps()
  end

  @doc false
  def changeset(movement, attrs) do
    movement
    |> cast(attrs, [:title, :amount, :origin, :type, :move_date])
    |> validate_required([:title, :amount, :type])
    |> validate_number(:amount, greater_than: 0.0)
    |> check_move_date()
  end

  defp check_move_date(changeset) do
    if !List.keyfind(changeset.errors, :move_date, 0) or Map.has_key?(changeset.changes, :move_date) do
      put_change(changeset, :move_date, Date.utc_today)
    else
      changeset
    end
  end
end
