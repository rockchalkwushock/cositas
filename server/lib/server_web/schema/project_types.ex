defmodule AppWeb.Schema.ProjectTypes do
  @moduledoc """
  Cositas Project Types
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias App.Accounts
  alias AppWeb.Resolvers
  alias AppWeb.Schema.Middleware

  import_types(AppWeb.Schema.EnumTypes)

  # Types

  @desc "Project"
  object :project do
    @desc "Date project was archived."
    field :archived_at, :datetime
    @desc "Date project was created."
    field :created_at, non_null(:datetime)
    @desc "Date project was deleted."
    field :deleted_at, :datetime
    @desc "Project end date."
    field :end_date, non_null(:datetime)
    field :id, non_null(:id)
    @desc "Date user was last modified."
    field :modified_at, non_null(:datetime)
    @desc "Project owner."
    field :owner, non_null(:user), resolve: dataloader(Accounts)
    @desc "Project start date."
    field :start_date, non_null(:datetime)
    @desc "Project status."
    field :status, non_null(:project_status)
    @desc "Project title."
    field :title, non_null(:string)
  end

  # Queries
  @desc "Project Queries"
  object :project_queries do
    @desc "Get all projects."
    field :projects, list_of(:project) do
      # TODO add args for filtering in Ecto.
      resolve &Resolvers.Content.projects/3
      middleware Middleware.HandleError
    end
    @desc "Get a project."
    field :project, :project do
      arg :id, non_null(:string)
      resolve &Resolvers.Content.project/3
      middleware Middleware.HandleError
    end
  end

  # Mutations
  @desc "Project Mutations"
  object :project_mutations do
    @desc "Add a Project"
    field :add_project, :project_payload do
      arg :inputs, non_null(:add_project_inputs)
      middleware Middleware.Authenticate
      resolve &Resolvers.Content.add_project/3
      middleware Middleware.HandleError
    end
    @desc "Archive a Project"
    field :archive_project, :project_payload do
      arg :inputs, non_null(:archive_project_inputs)
      middleware Middleware.Authenticate
      resolve &Resolvers.Content.archive_project/3
      middleware Middleware.HandleError
    end
    @desc "Edit a Project"
    field :edit_project, :project_payload do
      arg :inputs, non_null(:edit_project_inputs)
      middleware Middleware.Authenticate
      resolve &Resolvers.Content.edit_project/3
      middleware Middleware.HandleError
    end
    @desc "Remove a Project"
    field :remove_project, :project_payload do
      arg :inputs, non_null(:remove_project_inputs)
      middleware Middleware.Authenticate
      resolve &Resolvers.Content.remove_project/3
      middleware Middleware.HandleError
    end
  end

  # Mutation Inupts
  @desc "Inputs for Adding a Project."
  input_object :add_project_inputs do
    field :end_date, non_null(:string)
    field :start_date, non_null(:string)
    field :title, non_null(:string)
  end

  @desc "Inputs for Archiving a Project."
  input_object :archive_project_inputs do
    field :id, non_null(:string)
  end

  @desc "Inputs for Editing a Project."
  input_object :edit_project_inputs do
    field :end_date, :string
    field :id, non_null(:string)
    field :start_date, :string
    field :status, :project_status
    field :title, :string
  end

  @desc "Inputs for Removing a Project."
  input_object :remove_project_inputs do
    field :id, non_null(:string)
  end

  # Mutation Payloads
  @desc "Project Payload"
  object :project_payload do
    field :data, :project
    field :errors, list_of(:error_type)
  end
end
