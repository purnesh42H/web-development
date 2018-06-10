# Tracker
You can initially think of a "Task Tracker" as being kind of like the "Issues" feature on Github. Visit the sample app [here](http://tasks2.purneshdixit.stream)

Users of your app should be able to:

Register an account
- Log in / Log out
- Create Tasks, entering a title and a description
- Assign tasks to themselves or other users
- Track how long they've worked on a task they're assigned to, in 15-minute increments.
- Mark a task as completed.

To log in, you have to use your name and password. If you are not a user yet, you can register using name, email and password

## Design Choices
- I have created two tables
  - Users (See [here](priv/repo/migrations/20180403220113_create_users.exs))
  - Tasks (See [here](priv/repo/migrations/20180403220514_create_tasks.exs))

- Users table is a simple table to store the user's details like name, email
- Users table also stores the hash of the user's password
- Tasks table stores the tasks assigned to each user and hence there is foreign key constraint on user_id field of tasks
- All the fields for now are mandatory and does not allow null
- minutes field has a default value set to 0 and is validated to be a multiple of 15. For example: minutes spent cannot be 27 but can be 30.
- At front end, you can use the scroll in the minute text box for increment in step of 15.
- is_completed has a default value set to false which means task has not been completed yet.

- In this version, any logged in user can assign task to any user and edit any task details

## Layout Information
- Landing page is a login page. You have to register using an email, name and password and then login
- If you are logged in, your landing page has following
  - Task
    - A form to create new task
    - List of Tasks
    - Each cell of task has two buttons to delete and change status of task(complete/resume) and one link to take you to edit form
  - All Users
    - List of all Users
    - Each user has a link to see their respective tasks

## Maintaining Sessions
One annoyance of a SPA is that sessions don’t work by default. To fix this, we have two basic options:
- Do sessions the same as before, and add the session plugs to our API scope. This works, but it breaks other API consumers (e.g. the mobile app).
- Treat the whole thing as API authentication. This requires some more manual effort, but will work to authenticate both other JSON API consumers and your websocket connection.

We have done the hard way.

- We are using following modules for secure logins
  - {:comeonin, "~> 4.0"},
  - {:argon2_elixir, "~> 1.2"},

## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
