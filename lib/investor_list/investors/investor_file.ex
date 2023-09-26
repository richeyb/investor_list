defmodule InvestorList.Investors.InvestorFile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "investor_files" do
    field :filename, :string
    field :path, :string

    belongs_to :investor, InvestorList.Investors.Investor

    timestamps()
  end

  @doc false
  def changeset(investor_file, attrs) do
    investor_file
    |> cast(attrs, [:path, :filename])
    |> validate_required([:path, :filename])
  end
end
