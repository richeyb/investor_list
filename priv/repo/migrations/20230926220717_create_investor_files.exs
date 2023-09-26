defmodule InvestorList.Repo.Migrations.CreateInvestorFiles do
  use Ecto.Migration

  def change do
    create table(:investor_files) do
      add :path, :string
      add :filename, :string

      add :investor_id, references(:investors, on_delete: :nothing)

      timestamps()
    end
  end
end
