defmodule BloodbankWeb.UserDetail do
  use BloodbankWeb, :model

  schema "user_details" do
    field :firstname, :string
    field :lastname, :string
    field :age, :integer
    field :contact, :string
    field :email, :string
    field :blood_group, :string
    field :address, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:firstname, :lastname, :age, :contact, :email, :blood_group, :address])
    |> validate_required([:firstname, :lastname, :age, :contact, :email, :blood_group, :address])
    |> validate_format(:email, ~r/@/)
    |> valid_contact(:contact)
    |> unique_constraint([:contact])
    |> unique_constraint([:email])
  end

  def valid_contact(changeset, field) do
    contact = get_field(changeset, field)

    unless contact === nil do
      if String.length(contact) !== 10 do
        add_error(changeset, field, "invalid phone number")
      else
        changeset
      end
    else
      changeset
    end
  end
end
