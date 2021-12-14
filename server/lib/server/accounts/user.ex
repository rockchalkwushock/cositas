defmodule App.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Content.Project

  @required_fields [:email, :first_name, :last_name, :password, :username]
  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :hashed_password, :string, redact: true
    field :last_name, :string
    field :password, :string, virtual: true, redact: true
    field :username, :string

    has_many :projects, Project, foreign_key: :owner_id

    timestamps(@timestamps_opts)
  end

  @doc false
  def changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_email()
    |> validate_password(opts)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, App.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 8, max: 72)
    |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> maybe_hash_password(opts)
  end

  defp validate_username(changeset) do
    changeset
    |> validate_required([:username])
    |> validate_length(:username, min: 6)
    |> validate_length(:username, max: 18)
    |> unique_constraint(:username)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      # If using Bcrypt, then further validate it is at most 72 bytes long
      |> validate_length(:password, max: 72, count: :bytes)
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end
end
