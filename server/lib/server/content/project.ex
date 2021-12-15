defmodule App.Content.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Accounts.User

  @optional_fields [:archived_at, :deleted_at]
  @required_fields [:end_date, :start_date, :title]
  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  schema "projects" do
    field :archived_at, :utc_datetime_usec
    field :deleted_at, :utc_datetime_usec
    field :end_date, :utc_datetime_usec
    field :start_date, :utc_datetime_usec
    field :status, Ecto.Enum, values: [:archived, :finished, :in_progress, :unstarted], default: :unstarted
    field :title, :string

    belongs_to :owner, User, foreign_key: :owner_id

    timestamps(@timestamps_opts)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_start_date_before_end_date()
    |> assoc_constraint(:owner)
  end

  defp validate_start_date_before_end_date(changeset) do
    case changeset.valid? do
      true ->
        start_date = get_field(changeset, :start_date)
        end_date = get_field(changeset, :end_date)

        case Date.compare(start_date, end_date) do
          :gt ->
            add_error(changeset, :start_date, "cannot be after :end_date")
          _ ->
            changeset
        end
      _ ->
        changeset
    end
  end
end
