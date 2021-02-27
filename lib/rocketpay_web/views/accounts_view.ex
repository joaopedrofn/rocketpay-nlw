defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transfers.Response, as: TransferResponse

  def render("update.json", %{
        account: %Account{
          id: id,
          balance: balance
        }
      }) do
    %{
      message: "Balance changed successfully",
      account: %{
        id: id,
        balance: balance
      }
    }
  end

  def render("transfer.json", %{
        transfer: %TransferResponse{
          to_account: to_account,
          from_account: from_account
        }
      }) do
    %{
      message: "Transfer completed successfully",
      transfer: %{
        to_account: %{id: to_account.id, balance: to_account.balance},
        from_account: %{id: from_account.id, balance: from_account.balance}
      }
    }
  end
end
