defmodule AppWeb.Schema.Query.MeTest do
  use AppWeb.ConnCase, async: true

  import App.AccountsFixtures

  @query"""
  {
    me {
      id
      username
    }
  }
  """
  test "me query returns user" do
    user = user_fixture()

    conn = build_conn() |> auth_user(user)

    conn = get conn, "/api", query: @query

    assert %{
      "data" => %{
        "me" => %{
          "username" => username
        }
      }
    } = json_response(conn, 200)

    assert username == user.username
  end
end
