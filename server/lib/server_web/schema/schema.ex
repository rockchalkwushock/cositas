defmodule AppWeb.Schema.Schema do
  @moduledoc """
  Cositas GraphQL Schema
  """
  use Absinthe.Schema

  alias App.{Accounts,Content}


  import_types(Absinthe.Type.Custom)
  import_types(AppWeb.Schema.InternalTypes)
  import_types(AppWeb.Schema.ProjectTypes)
  import_types(AppWeb.Schema.UserTypes)

  # Add all dataloaders to the Absinthe Context.
  # This will make them accessible within the resolvers.
  def context(ctx) do
    loader =
      Dataloader.new
        |> Dataloader.add_source(Accounts, Accounts.data())
        |> Dataloader.add_source(Content, Content.data())

    Map.put(ctx, :loader, loader)
  end

  # Add dataloader to the available plugins.
  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    import_fields(:project_queries)
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:project_mutations)
    import_fields(:user_mutations)
  end
end
