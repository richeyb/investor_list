defmodule InvestorList.Investors do
  @moduledoc """
  The Investors context.
  """

  import Ecto.Query, warn: false
  alias InvestorList.Repo

  alias InvestorList.Investors.Investor

  @doc """
  Returns the list of investors.

  ## Examples

      iex> list_investors()
      [%Investor{}, ...]

  """
  def list_investors do
    Repo.all(Investor) |> Repo.preload(:investor_files)
  end

  @doc """
  Gets a single investor.

  Raises `Ecto.NoResultsError` if the Investor does not exist.

  ## Examples

      iex> get_investor!(123)
      %Investor{}

      iex> get_investor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_investor!(id), do: Repo.get!(Investor, id) |> Repo.preload(:investor_files)

  @doc """
  Creates a investor.

  ## Examples

      iex> create_investor(%{field: value})
      {:ok, %Investor{}}

      iex> create_investor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_investor(attrs \\ %{}) do
    %Investor{}
    |> Investor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a investor.

  ## Examples

      iex> update_investor(investor, %{field: new_value})
      {:ok, %Investor{}}

      iex> update_investor(investor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_investor(%Investor{} = investor, attrs) do
    investor
    |> Investor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a investor.

  ## Examples

      iex> delete_investor(investor)
      {:ok, %Investor{}}

      iex> delete_investor(investor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_investor(%Investor{} = investor) do
    Repo.delete(investor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking investor changes.

  ## Examples

      iex> change_investor(investor)
      %Ecto.Changeset{data: %Investor{}}

  """
  def change_investor(%Investor{} = investor, attrs \\ %{}) do
    Investor.changeset(investor, attrs)
  end

  @doc """
  Returns true if the investor exists with the given `attrs`, false
  otherwise.

  ## Examples

      iex> is_duplicate?(%{"first_name" => "John", "last_name" => "Doe", "date_of_birth" => "1980-01-01"})
      false

  """
  def is_duplicate?(%{"first_name" => first_name, "last_name" => last_name, "date_of_birth" => date_of_birth}) do
    query = from i in Investor,
      where: fragment("? ilike ?", i.first_name, ^first_name),
      where: fragment("? ilike ?", i.last_name, ^last_name),
      where: (i.date_of_birth == ^date_of_birth)
    Repo.exists?(query)
  end

  @doc """
  Returns the investor if the investor exists with the given `attrs`, otherwise returns nil

  ## Examples

      iex> get_duplicate(%{"first_name" => "John", "last_name" => "Doe", "date_of_birth" => "1980-01-01"})
      %Investor{...}

      iex> get_duplicate(%{"first_name" => "Jane", "last_name" => "Doe", "date_of_birth" => "1980-01-01"})
      nil

  """
  def get_duplicate(%{"first_name" => first_name, "last_name" => last_name, "date_of_birth" => date_of_birth})
    when not is_nil(first_name) and not is_nil(last_name) and not is_nil(date_of_birth)
  do
    query = from i in Investor,
      where: fragment("? ilike ?", i.first_name, ^first_name),
      where: fragment("? ilike ?", i.last_name, ^last_name),
      where: (i.date_of_birth == ^date_of_birth)
    Repo.one(query)
  end
  def get_duplicate(_), do: nil
end
