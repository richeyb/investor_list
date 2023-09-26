defmodule InvestorList.Investors.Investor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "investors" do
    field :state, :string
    field :first_name, :string
    field :last_name, :string
    field :date_of_birth, :date
    field :phone_number, :string
    field :street_address, :string
    field :zip_code, :string

    has_many :investor_files, InvestorList.Investors.InvestorFile

    timestamps()
  end

  @doc false
  def changeset(investor, attrs) do
    investor
    |> cast(attrs, [:first_name, :last_name, :date_of_birth, :phone_number, :street_address, :state, :zip_code])
    |> validate_required([:first_name, :last_name, :date_of_birth, :phone_number, :street_address, :state, :zip_code])
  end
end
