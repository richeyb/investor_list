defmodule InvestorListWeb.InvestorController do
  use InvestorListWeb, :controller

  alias InvestorList.Investors
  alias InvestorList.Investors.Investor

  def index(conn, _params) do
    investors = Investors.list_investors()
    render(conn, :index, investors: investors)
  end

  def new(conn, _params) do
    changeset = Investors.change_investor(%Investor{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"investor" => investor_params}) do
    case Investors.create_investor(investor_params) do
      {:ok, investor} ->
        conn
        |> put_flash(:info, "Investor created successfully.")
        |> redirect(to: ~p"/investors/#{investor}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    investor = Investors.get_investor!(id)
    render(conn, :show, investor: investor)
  end

  def edit(conn, %{"id" => id}) do
    investor = Investors.get_investor!(id)
    changeset = Investors.change_investor(investor)
    render(conn, :edit, investor: investor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "investor" => investor_params}) do
    investor = Investors.get_investor!(id)

    case Investors.update_investor(investor, investor_params) do
      {:ok, investor} ->
        conn
        |> put_flash(:info, "Investor updated successfully.")
        |> redirect(to: ~p"/investors/#{investor}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, investor: investor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    investor = Investors.get_investor!(id)
    {:ok, _investor} = Investors.delete_investor(investor)

    conn
    |> put_flash(:info, "Investor deleted successfully.")
    |> redirect(to: ~p"/investors")
  end
end
