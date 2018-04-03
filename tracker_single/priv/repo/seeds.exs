# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TrackerSingle.Repo.insert!(%TrackerSingle.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule Seeds do
  alias TrackerSingle.Repo
  alias TrackerSingle.Users.User
  alias TrackerSingle.Tasks.Task

  def run do
    Repo.delete_all(User)
    a = Repo.insert!(%User{ name: "alice", email: "alice@xyz.com" })
    b = Repo.insert!(%User{ name: "bob", email: "bob@example.com" })
    c = Repo.insert!(%User{ name: "carol", email: "carol@some.com" })
    d = Repo.insert!(%User{ name: "dave", email: "dave@xyz.com" })

    Repo.delete_all(Task)
    Repo.insert!(%Task{ user_id: a.id, title: "sql fix", description: "sql fix", minutes: 0, is_completed: false })
    Repo.insert!(%Task{ user_id: b.id, title: "UI not rendering", description: "UI", minutes: 15, is_completed: false })
    Repo.insert!(%Task{ user_id: b.id, title: "brunch error", description: "brunch", minutes: 15, is_completed: false })
    Repo.insert!(%Task{ user_id: c.id, title: "brk failed", description: "brk failed", minutes: 60, is_completed: true })
    Repo.insert!(%Task{ user_id: d.id, title: "segmentation fault", description: "seg fault", minutes: 240, is_completed: false })
  end
end

Seeds.run
