defmodule TrackerSingleWeb.TaskView do
  use TrackerSingleWeb, :view
  alias TrackerSingleWeb.TaskView
  alias TrackerSingleWeb.UserView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      title: task.title,
      description: task.description,
      minutes: task.minutes,
      is_completed: task.is_completed,
      user: render_one(task.user, UserView, "user.json")}
  end
end
