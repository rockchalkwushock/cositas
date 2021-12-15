defmodule App.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Content` context.
  """
  alias App.Content

  @doc """
  Generate a project.
  """
  def project_fixture(user, attrs \\ %{}) do
    p =
      attrs
      |> Enum.into(%{
        end_date: ~U[2025-12-31 23:59:59.000000Z],
        start_date: ~U[2021-12-13 08:15:00.000000Z],
        title: "My New Project"
      })

    {:ok, project} = Content.create_project(user, p)

    project
  end
end
