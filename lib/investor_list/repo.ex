defmodule InvestorList.Repo do
  use Ecto.Repo,
    otp_app: :investor_list,
    adapter: Ecto.Adapters.Postgres
end
