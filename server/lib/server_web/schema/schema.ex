defmodule AppWeb.Schema.Schema do
  @moduledoc """
  Cositas GraphQL Schema
  """
  use Absinthe.Schema

  import_types(AppWeb.Schema.UserTypes)

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end
end
