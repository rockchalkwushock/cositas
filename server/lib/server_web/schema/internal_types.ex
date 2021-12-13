defmodule AppWeb.Schema.InternalTypes do
  @moduledoc """
  Cositas Internal Types
  """
  use Absinthe.Schema.Notation

  @desc "Mutation ErrorType."
  object :error_type do
    @desc "Field in which error occurred on."
    field :field, non_null(:string)
    @desc "Validation error message for corresponding field."
    field :message, non_null(:string)
  end

  @desc "Mutation Data Object."
  object :data do
    field :message, non_null(:string)
  end
end
