defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: UserCreate
  alias Rocketpay.Users.SignIn
  alias Rocketpay.Accounts.{Deposit, Withdraw, Transfer}
  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transfer(params), to: Transfer, as: :call
  defdelegate sign_in(params), to: SignIn, as: :call
end
