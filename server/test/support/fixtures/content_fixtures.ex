defmodule App.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Content` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        archived_at: ~U[2021-12-13 08:15:00.000000Z],
        deleted_at: ~U[2021-12-13 08:15:00.000000Z],
        due_date: ~U[2021-12-13 08:15:00.000000Z],
        title: "some title"
      })
      |> App.Content.create_project()

    project
  end
end
