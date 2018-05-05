defmodule LogApi.Shipment.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :eventlog, :string
    field :pkgname, :string
    field :ship_dte, :date

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:ship_dte, :pkgname, :eventlog])
    |> validate_required([:ship_dte, :pkgname, :eventlog])
  end
end
