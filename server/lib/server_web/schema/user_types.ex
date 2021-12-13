defmodule AppWeb.Schema.UserTypes do
  @moduledoc """
  Cositas User Types
  """
  use Absinthe.Schema.Notation
  alias AppWeb.Resolvers
  alias AppWeb.Schema.Middleware

  import_types(AppWeb.Schema.InternalTypes)
  import_types(AppWeb.Schema.SessionTypes)

  # Types

  @desc "User"
  object :user do
    @desc "Date user was created."
    field :created_at, non_null(:string)
    @desc "User's email."
    field :email, non_null(:string)
    @desc "User's first name."
    field :first_name, non_null(:string)
    field :id, non_null(:id)
    @desc "User's last name."
    field :last_name, non_null(:string)
    @desc "Date user was last modified."
    field :modified_at, non_null(:string)
    @desc "User's username."
    field :username, non_null(:string)
  end

  # Queries
  @desc "User Queries"
  object :user_queries do
    @desc "Get the currently signed in user."
    field :me, :user do
      resolve &Resolvers.Accounts.me/3
      middleware Middleware.HandleError
    end
  end

  # Mutations
  @desc "User Mutations"
  object :user_mutations do
     @desc "Register a new user account."
      field :register, :authentication_payload do
        arg :inputs, non_null(:registration_inputs)
        resolve &Resolvers.Accounts.register/3
        middleware Middleware.HandleError
      end

      @desc "Sign in a user"
      field :sign_in, :authentication_payload do
        arg :inputs, non_null(:sign_in_inputs)
        resolve &Resolvers.Accounts.sign_in/3
        middleware Middleware.HandleError
      end
  end

  # Mutation Inupts
  @desc "Inputs for Registering a new user."
  input_object :registration_inputs do
    field :email, non_null(:string)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
    field :password, non_null(:string)
    field :username, non_null(:string)
  end

  @desc "Inputs for Authenticating a user."
  input_object :sign_in_inputs do
    field :password, non_null(:string)
    field :username, non_null(:string)
  end

  # Mutation Payloads
  @desc "Authentication Payload"
  object :authentication_payload do
    field :data, :session
    field :errors, list_of(:error_type)
  end
end
