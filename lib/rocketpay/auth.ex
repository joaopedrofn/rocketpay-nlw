defmodule Rocketpay.Auth do
  # 24 hours
  @max_age 86_400
  @token_secret Application.get_env(:rocketpay, :token_secret)

  use RocketpayWeb, :controller
  import Plug.Conn

  alias Phoenix.Token

  def init(default), do: default

  def call(conn, _default) do
    authorization_header = get_req_header(conn, "authorization")

    token = List.last(Regex.split(~r/Bearer /, List.first(authorization_header)))

    Token.verify(conn, @token_secret, token, max_age: @max_age)
    |> handle_result(conn)
  end

  defp handle_result(result, conn) do
    case result do
      {:ok, _id} ->
        conn

      {:error, reason} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(RocketpayWeb.ErrorView)
        |> render("400.json", result: reason)
    end
  end
end
