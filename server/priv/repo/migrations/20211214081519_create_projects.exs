defmodule App.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  def change do
    create table(:projects) do
      add :archived_at, :utc_datetime_usec
      add :deleted_at, :utc_datetime_usec
      add :end_date, :utc_datetime_usec, null: false
      add :start_date, :utc_datetime_usec, null: false
      add :status, :string, default: "unstarted", null: false
      add :title, :string, null: false
      add :owner_id, references(:users, on_delete: :delete_all), null: false

      timestamps(@timestamps_opts)
    end

    create index(:projects, [:owner_id])
  end
end
