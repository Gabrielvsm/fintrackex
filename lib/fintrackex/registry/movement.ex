defmodule Fintrackex.Registry.Movement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movements" do
    field :amount, :float
    field :origin, :string
    field :title, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(movement, attrs) do
    movement
    |> cast(attrs, [:title, :amount, :origin, :type])
    |> validate_required([:title, :amount, :type])
    |> validate_inclusion(:type, ["expense", "income"], message: "ivalid! type must be 'expense' or 'income'")
    |> validate_number(:amount, greater_than: 0.0)
  end
end
