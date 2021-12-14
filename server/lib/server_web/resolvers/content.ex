defmodule AppWeb.Resolvers.Content do
  alias App.Content

  def projects(_, _, _) do
    {:ok, Content.list_projects()}
  end

  def project(_, %{id: id}, _) do
    {:ok, Content.get_project!(id)}
  end

  def add_project(_, %{inputs: inputs}, %{context: %{current_user: user}}) do
    case Content.create_project(user, inputs) do
      {:error, changeset} ->
        {:error, changeset}
      {:ok, project} ->
        {:ok, project}
    end
  end

  def edit_project(_, %{inputs: inputs}, %{context: %{current_user: user}}) do
    project = Content.get_project!(inputs["id"])

    if (project.owner_id == user.id) do
      case Content.update_project(project, inputs) do
        {:error, changeset} ->
          {:error, changeset}
        {:ok, project} ->
          {:ok, project}
      end
    else
      {
        :error,
        message: "You cannot edit this project."
      }
    end
  end

  def remove_project(_, %{inputs: inputs}, %{context: %{current_user: user}}) do
    project = Content.get_project!(inputs["id"])

    if (project.owner_id == user.id) do
      case Content.delete_project(project) do
        {:error, changeset} ->
          {:error, changeset}
        {:ok, project} ->
          {:ok, project}
      end
    else
      {
        :error,
        message: "You cannot delete this project."
      }
    end
  end
end
