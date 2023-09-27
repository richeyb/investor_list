defmodule InvestorList.InvestorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `InvestorList.Investors` context.
  """

  @doc """
  Generate a investor.
  """
  def investor_fixture(attrs \\ %{}) do
    {:ok, investor} =
      attrs
      |> Enum.into(%{
        state: "some state",
        first_name: "some first_name",
        last_name: "some last_name",
        date_of_birth: ~D[2023-09-25],
        phone_number: "some phone_number",
        street_address: "some street_address",
        zip_code: "some zip_code",
        investor_files: [
          %{
            filename: "some filename",
            path: "some path"
          }
        ]
      })
      |> InvestorList.Investors.create_investor()

    investor
  end
end
