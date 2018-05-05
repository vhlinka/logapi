defmodule LogApi.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :ship_dte, :date
      add :pkgname, :string
      add :eventlog, :string

      timestamps()
    end

  end
end
