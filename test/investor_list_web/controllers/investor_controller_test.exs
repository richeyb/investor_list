defmodule InvestorListWeb.InvestorControllerTest do
  use InvestorListWeb.ConnCase

  import InvestorList.InvestorsFixtures

  @create_attrs %{state: "some state", first_name: "some first_name", last_name: "some last_name", date_of_birth: ~D[2023-09-25], phone_number: "some phone_number", street_address: "some street_address", zip_code: "some zip_code"}
  @update_attrs %{state: "some updated state", first_name: "some updated first_name", last_name: "some updated last_name", date_of_birth: ~D[2023-09-26], phone_number: "some updated phone_number", street_address: "some updated street_address", zip_code: "some updated zip_code"}
  @invalid_attrs %{state: nil, first_name: nil, last_name: nil, date_of_birth: nil, phone_number: nil, street_address: nil, zip_code: nil}

  describe "index" do
    test "lists all investors", %{conn: conn} do
      conn = get(conn, ~p"/investors")
      assert html_response(conn, 200) =~ "Listing Investors"
    end
  end

  describe "new investor" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/investors/new")
      assert html_response(conn, 200) =~ "New Investor"
    end
  end

  describe "create investor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/investors", investor: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/investors/#{id}"

      conn = get(conn, ~p"/investors/#{id}")
      assert html_response(conn, 200) =~ "Investor #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/investors", investor: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Investor"
    end
  end

  describe "edit investor" do
    setup [:create_investor]

    test "renders form for editing chosen investor", %{conn: conn, investor: investor} do
      conn = get(conn, ~p"/investors/#{investor}/edit")
      assert html_response(conn, 200) =~ "Edit Investor"
    end
  end

  describe "update investor" do
    setup [:create_investor]

    test "redirects when data is valid", %{conn: conn, investor: investor} do
      conn = put(conn, ~p"/investors/#{investor}", investor: @update_attrs)
      assert redirected_to(conn) == ~p"/investors/#{investor}"

      conn = get(conn, ~p"/investors/#{investor}")
      assert html_response(conn, 200) =~ "some updated state"
    end

    test "renders errors when data is invalid", %{conn: conn, investor: investor} do
      conn = put(conn, ~p"/investors/#{investor}", investor: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Investor"
    end
  end

  describe "delete investor" do
    setup [:create_investor]

    test "deletes chosen investor", %{conn: conn, investor: investor} do
      conn = delete(conn, ~p"/investors/#{investor}")
      assert redirected_to(conn) == ~p"/investors"

      assert_error_sent 404, fn ->
        get(conn, ~p"/investors/#{investor}")
      end
    end
  end

  defp create_investor(_) do
    investor = investor_fixture()
    %{investor: investor}
  end
end
