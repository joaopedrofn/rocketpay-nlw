defmodule Rocketpay.Users.SignIn do
  alias Rocketpay.{Repo, User}

  def call(%{"password" => password, "nickname" => _nickname} = params) do
    params
    |> get_user()
    |> Bcrypt.check_pass(password)
  end

  defp get_user(%{"nickname" => nickname}) do
    case Repo.get_by(User, nickname: nickname) do
      nil -> {:error, "User not found!"}
      user -> user
    end
  end
end
