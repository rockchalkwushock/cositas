defmodule App.ContentTest do
  use App.DataCase

  alias App.Content

  describe "projects" do
    alias App.Content.Project

    import App.ContentFixtures

    @invalid_attrs %{archived_at: nil, deleted_at: nil, due_date: nil, title: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Content.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Content.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{archived_at: ~U[2021-12-13 08:15:00.000000Z], deleted_at: ~U[2021-12-13 08:15:00.000000Z], due_date: ~U[2021-12-13 08:15:00.000000Z], title: "some title"}

      assert {:ok, %Project{} = project} = Content.create_project(valid_attrs)
      assert project.archived_at == ~U[2021-12-13 08:15:00.000000Z]
      assert project.deleted_at == ~U[2021-12-13 08:15:00.000000Z]
      assert project.due_date == ~U[2021-12-13 08:15:00.000000Z]
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{archived_at: ~U[2021-12-14 08:15:00.000000Z], deleted_at: ~U[2021-12-14 08:15:00.000000Z], due_date: ~U[2021-12-14 08:15:00.000000Z], title: "some updated title"}

      assert {:ok, %Project{} = project} = Content.update_project(project, update_attrs)
      assert project.archived_at == ~U[2021-12-14 08:15:00.000000Z]
      assert project.deleted_at == ~U[2021-12-14 08:15:00.000000Z]
      assert project.due_date == ~U[2021-12-14 08:15:00.000000Z]
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_project(project, @invalid_attrs)
      assert project == Content.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Content.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Content.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Content.change_project(project)
    end
  end
end
