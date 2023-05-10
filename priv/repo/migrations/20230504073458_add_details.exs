defmodule Bloodbank.Repo.Migrations.AddDetails do
  use Ecto.Migration

  def change do
    create table(:user_details) do
      add :firstname, :string
      add :lastname, :string
      add :age, :integer
      add :contact, :string
      add :email, :string
      add :blood_group, :string
      add :address, :string
    end

    create unique_index(:user_details, [:contact])
    create unique_index(:user_details, [:email])
  end
end
