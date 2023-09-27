defmodule InvestorList.InvestorsTest do
  use InvestorList.DataCase

  alias InvestorList.Investors

  describe "investors" do
    alias InvestorList.Investors.Investor

    import InvestorList.InvestorsFixtures

    @invalid_attrs %{state: nil, first_name: nil, last_name: nil, date_of_birth: nil, phone_number: nil, street_address: nil, zip_code: nil}

    test "list_investors/0 returns all investors" do
      investor = investor_fixture()
      assert Investors.list_investors() == [investor]
    end

    test "get_investor!/1 returns the investor with given id" do
      investor = investor_fixture()
      assert Investors.get_investor!(investor.id) == investor
    end

    test "create_investor/1 with valid data creates a investor" do
      valid_attrs = %{state: "some state", first_name: "some first_name", last_name: "some last_name", date_of_birth: ~D[2023-09-25], phone_number: "some phone_number", street_address: "some street_address", zip_code: "some zip_code"}

      assert {:ok, %Investor{} = investor} = Investors.create_investor(valid_attrs)
      assert investor.state == "some state"
      assert investor.first_name == "some first_name"
      assert investor.last_name == "some last_name"
      assert investor.date_of_birth == ~D[2023-09-25]
      assert investor.phone_number == "some phone_number"
      assert investor.street_address == "some street_address"
      assert investor.zip_code == "some zip_code"
    end

    test "create_investor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Investors.create_investor(@invalid_attrs)
    end

    test "update_investor/2 with valid data updates the investor" do
      investor = investor_fixture()
      update_attrs = %{state: "some updated state", first_name: "some updated first_name", last_name: "some updated last_name", date_of_birth: ~D[2023-09-26], phone_number: "some updated phone_number", street_address: "some updated street_address", zip_code: "some updated zip_code"}

      assert {:ok, %Investor{} = investor} = Investors.update_investor(investor, update_attrs)
      assert investor.state == "some updated state"
      assert investor.first_name == "some updated first_name"
      assert investor.last_name == "some updated last_name"
      assert investor.date_of_birth == ~D[2023-09-26]
      assert investor.phone_number == "some updated phone_number"
      assert investor.street_address == "some updated street_address"
      assert investor.zip_code == "some updated zip_code"
    end

    test "update_investor/2 with invalid data returns error changeset" do
      investor = investor_fixture()
      assert {:error, %Ecto.Changeset{}} = Investors.update_investor(investor, @invalid_attrs)
      assert investor == Investors.get_investor!(investor.id)
    end

    test "delete_investor/1 deletes the investor" do
      investor = investor_fixture()
      assert {:ok, %Investor{}} = Investors.delete_investor(investor)
      assert_raise Ecto.NoResultsError, fn -> Investors.get_investor!(investor.id) end
    end

    test "change_investor/1 returns a investor changeset" do
      investor = investor_fixture()
      assert %Ecto.Changeset{} = Investors.change_investor(investor)
    end

    test "get_duplicate/1 returns the investor with matching first name/last name/dob" do
      investor = investor_fixture()
      assert Investors.get_duplicate(%{"first_name" => investor.first_name, "last_name" => investor.last_name, "date_of_birth" => investor.date_of_birth}) == investor
    end

    test "get_duplicate/1 returns nil without matching first name/last name/dob" do
      investor = investor_fixture()
      assert is_nil(Investors.get_duplicate(%{"first_name" => "blgfdgfdlgfd!!", "last_name" => investor.last_name, "date_of_birth" => investor.date_of_birth}))
    end

    test "is_duplicate?/1 returns true with matching first name/last name/dob" do
      investor = investor_fixture()
      assert Investors.is_duplicate?(%{"first_name" => investor.first_name, "last_name" => investor.last_name, "date_of_birth" => investor.date_of_birth}) == true
    end

    test "is_duplicate?/1 returns false without matching first name/last name/dob" do
      investor = investor_fixture()
      assert Investors.is_duplicate?(%{"first_name" => "blgfdgfdlgfd!!", "last_name" => investor.last_name, "date_of_birth" => investor.date_of_birth}) == false
    end
  end
end
