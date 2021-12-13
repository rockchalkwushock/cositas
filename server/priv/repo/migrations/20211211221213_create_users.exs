defmodule App.Repo.Migrations.CreateUsers do
  use Ecto.Migration

    @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      add :email, :citext, null: false
      add :first_name, :string, null: false
      add :hashed_password, :string, null: false
      add :last_name, :string, null: false
      add :username, :string, null: false

      timestamps(@timestamps_opts)
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end
