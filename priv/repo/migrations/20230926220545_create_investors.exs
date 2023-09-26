defmodule InvestorList.Repo.Migrations.CreateInvestors do
  use Ecto.Migration

  def change do
    create table(:investors) do
      add :first_name, :string
      add :last_name, :string
      add :date_of_birth, :date
      add :phone_number, :string
      add :street_address, :text
      add :state, :string
      add :zip_code, :string

      timestamps()
    end
  end
end
