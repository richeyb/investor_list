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

  def create(conn, %{"investor" => _investor_params}=params) do
    investor_params = add_investor_file_params(params)

    case Investors.get_duplicate(investor_params) do
      nil ->
        # If the investor doesn't exist already, create away
        case Investors.create_investor(investor_params) do
          {:ok, investor} ->
            conn
            |> put_flash(:info, "Investor created successfully.")
            |> redirect(to: ~p"/investors/#{investor}")

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, :new, changeset: changeset)
        end
      existing_investor ->
        # Otherwise update the existing investor
        update_investor(conn, existing_investor, investor_params)
    end
  end

  # If we have file data, add it to the params
  defp add_investor_file_params(%{"investor" => investor_params, "files" => file_params}) do
    files = handle_file_uploads(file_params)
    Map.put(investor_params, "investor_files", files)
  end
  defp add_investor_file_params(%{"investor" => investor_params}), do: investor_params

  defp handle_file_uploads(files) when is_list(files) and not is_nil(files) do
    Enum.map(files, fn file ->
      # For each file, figure out the root directory, the path, and copy the file
      directory = Path.join([:code.priv_dir(:investor_list), "static", "uploads"])
      # Inject a random string to try to avoid clobbering existing files
      path = Path.join([directory, "#{random_string(8)}-#{file.filename}"])
      File.cp!(file.path, path)
      %{ filename: file.filename, path: path }
    end)
  end
  # We have no file data, so don't do any work
  defp handle_file_uploads(_), do: nil

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

    update_investor(conn, investor, investor_params)
  end

  defp update_investor(conn, investor, investor_params) do
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

  # Pulled this one from StackOverflow
  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
