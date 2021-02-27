defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User
  alias Phoenix.Token

  action_fallback RocketpayWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def sign_in(conn, params) do
    with {:ok, %User{id: user_id} = user} <- Rocketpay.sign_in(params) do
      token = Token.sign(conn, Application.get_env(:rocketpay, :token_secret), user_id)

      conn
      |> put_status(:ok)
      |> render("signed.json", user: user, token: token)
    end
  end
end
