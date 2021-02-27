defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transfers.Response, as: TransferResponse

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transfer(conn, params) do
    task = Task.async(fn -> Rocketpay.transfer(params) end)

    with {:ok, %TransferResponse{} = transfer} <- Task.await(task) do
      conn
      |> put_status(:ok)
      |> render("transfer.json", transfer: transfer)
    end
  end
end
