defmodule AppWeb.Schema.Mutation.EditProjectTest do
  use AppWeb.ConnCase, async: true
  alias Faker
  import App.AccountsFixtures
  import App.ContentFixtures

  @query"""
  mutation EditProject($inputs: EditProjectInputs!) {
    editProject(inputs: $inputs) {
      data {
        endDate
        id
        status
        title
      }
      errors {
        field
        message
      }
    }
  }
  """
  test "editing a project" do
    user = user_fixture()
    project = project_fixture(user)

    assert project.status == :unstarted

    inputs = %{
      end_date: "2022-12-31T23:59:00.000000Z",
      id: to_string(project.id),
      status: "IN_PROGRESS",
      title: "My Really Really Cool Project"
    }

    conn = build_conn() |> auth_user(user)

    conn = post conn, "/api",
      query: @query,
      variables: %{ inputs: inputs }

    assert %{
      "data" => %{
        "editProject" => %{
          "data" => project,
          "errors" => errors
        }
      }
    } = json_response(conn, 200)

    assert errors == nil
    assert project["endDate"] == inputs.end_date
    assert project["status"] == inputs.status
    assert project["title"] == inputs.title
  end
end
