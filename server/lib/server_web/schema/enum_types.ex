defmodule AppWeb.Schema.EnumTypes do
  @moduledoc """
  Cositas Enum Types
  """
  use Absinthe.Schema.Notation

  @desc "Status of a Project"
  enum :project_status do
    value(:archived, description: "Archived state")
    value(:finished, description: "Finished state")
    value(:in_progress, description: "In Progress state")
    value(:unstarted, description: "Unstarted state")
  end
end
