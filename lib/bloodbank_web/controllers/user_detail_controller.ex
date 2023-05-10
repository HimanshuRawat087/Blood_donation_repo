defmodule BloodbankWeb.UserDetailController do
  use BloodbankWeb, :controller

  alias BloodbankWeb.UserDetail
  alias Bloodbank.Repo

  def index(conn, _params) do
    details = Repo.all(UserDetail)

    render(conn,:index,details: details)
  end

  def new(conn, _params) do
    changeset = UserDetail.changeset(%UserDetail{}, %{})

    render(conn, :detail, changeset: changeset)
  end

  def create(conn, %{
        "user_detail" => %{
          "firstname" => firstname,
          "lastname" => lastname,
          "age" => age,
          "contact" => contact,
          "email" => email,
          "blood_group" => blood_group,
          "address" => address
        }
      }) do
    changeset =
      UserDetail.changeset(%UserDetail{}, %{
        "firstname" => firstname,
        "lastname" => lastname,
        "age" => age,
        "contact" => contact,
        "email" => email,
        "blood_group" => blood_group,
        "address" => address
      })

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "request created successfully")
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        render(conn, :detail, changeset: changeset)
    end
  end
end
