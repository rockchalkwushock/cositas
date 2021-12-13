defmodule AppWeb.Schema.Middleware.HandleError do
  @behaviour Absinthe.Middleware

  import Enum, only: [flat_map: 2, map: 2]

  def call(resolution, _) do
    %{resolution |
      errors: flat_map(resolution.errors, &handle_error/1)
    }
  end

  defp handle_error(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn ({err, _opts}) -> err end)
    |> map(fn({k,v}) -> "#{k}: #{v}" end)
  end

  defp handle_error(error), do: [error]
end
