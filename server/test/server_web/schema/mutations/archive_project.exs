defmodule AppWeb.Schema.Mutation.ArchiveProjectTest do
  use AppWeb.ConnCase, async: true
  alias Faker
  import App.AccountsFixtures
  import App.ContentFixtures

  @query"""
  mutation ArchiveProject($inputs: ArchiveProjectInputs!) {
    archiveProject(inputs: $inputs) {
      data {
        archivedAt
        id
        status
      }
      errors {
        field
        message
      }
    }
  }
  """
  test "archiving a project" do
    user = user_fixture()
    project = project_fixture(user)

    assert project.status == :unstarted

    inputs = %{
      id: to_string(project.id),
    }

    conn = build_conn() |> auth_user(user)

    conn = post conn, "/api",
      query: @query,
      variables: %{ inputs: inputs }

    assert %{
      "data" => %{
        "archiveProject" => %{
          "data" => project,
          "errors" => errors
        }
      }
    } = json_response(conn, 200)

    assert errors == nil
    assert project["status"] == "ARCHIVED"
  end
end
