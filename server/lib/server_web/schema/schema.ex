defmodule AppWeb.Schema.Schema do
  @moduledoc """
  Cositas GraphQL Schema
  """
  use Absinthe.Schema

  import_types(AppWeb.Schema.InternalTypes)
  import_types(AppWeb.Schema.ProjectTypes)
  import_types(AppWeb.Schema.UserTypes)

  query do
    import_fields(:project_queries)
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:project_mutations)
    import_fields(:user_mutations)
  end
end
