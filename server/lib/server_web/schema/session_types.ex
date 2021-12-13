defmodule AppWeb.Schema.SessionTypes do
  @moduledoc """
  Cositas Session Types
  """
  use Absinthe.Schema.Notation

  @desc "User Session"
  object :session do
    @desc "A user's session token."
    field :token, non_null(:string)
    @desc "The currently authenticated user."
    field :user, non_null(:user)
  end
end
