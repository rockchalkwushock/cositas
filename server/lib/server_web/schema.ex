defmodule AppWeb.Schema do
  @moduledoc """
  Cositas GraphQL Schema
  """
  use Absinthe.Schema

  query do
    field :name, :string, resolve: fn _, _, _ -> {:ok, "Cody Brunner"} end
  end
end
