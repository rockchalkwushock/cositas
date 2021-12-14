# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Faker
alias App.Repo
alias App.Accounts.User
alias App.Content.Project

# Create a user
turd =
  %User{}
  |> User.changeset(%{
    email: "turd@gmail.com",
    first_name: "Turd",
    last_name: "Ferguson",
    password: "hello-World123**",
    username: "da1RealTurd"
  })
  |> Repo.insert!()

for _ <- 1..10 do
  %Project{
    end_date: Faker.DateTime.between(
          DateTime.to_naive(DateTime.utc_now()),
          DateTime.to_naive(Faker.DateTime.forward(30))
        ),
    owner_id: turd.id,
    start_date: DateTime.utc_now(),
    title: Faker.Lorem.word()
  } |> Repo.insert!()
end
