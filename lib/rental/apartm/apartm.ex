defmodule Rental.Apartm do
  @moduledoc """
  The Apartm context.
  """

  import Ecto.Query, warn: false
  alias Rental.Repo

  alias Rental.Apartm.Apartment

  @doc """
  Returns the list of apartments.

  ## Examples

      iex> list_apartments()
      [%Apartment{}, ...]

  """
  def list_apartments do
    Repo.all(Apartment)
  end

  @doc """
  Gets a single apartment.

  Raises `Ecto.NoResultsError` if the Apartment does not exist.

  ## Examples

      iex> get_apartment!(123)
      %Apartment{}

      iex> get_apartment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_apartment!(id), do: Repo.get!(Apartment, id)

  @doc """
  Creates a apartment.

  ## Examples

      iex> create_apartment(%{field: value})
      {:ok, %Apartment{}}

      iex> create_apartment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_apartment(attrs \\ %{}) do
    %Apartment{}
    |> Apartment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a apartment.

  ## Examples

      iex> update_apartment(apartment, %{field: new_value})
      {:ok, %Apartment{}}

      iex> update_apartment(apartment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_apartment(%Apartment{} = apartment, attrs) do
    apartment
    |> Apartment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Apartment.

  ## Examples

      iex> delete_apartment(apartment)
      {:ok, %Apartment{}}

      iex> delete_apartment(apartment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_apartment(%Apartment{} = apartment) do
    Repo.delete(apartment)
    |> IO.inspect(label: "Delete ID Do Not Exist ==========")
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking apartment changes.

  ## Examples

      iex> change_apartment(apartment)
      %Ecto.Changeset{source: %Apartment{}}

  """
  def change_apartment(%Apartment{} = apartment) do
    Apartment.changeset(apartment, %{})
  end


  # Custom Methods
  def my_apartments(user_id) do
      from(i in Apartment, where: i.user_id == ^user_id)
      |> Repo.all()
      |> checker
  end
  
  defp checker(list_to_check) do
    with resp = [_|_] <- list_to_check do
      {:ok, resp}
    else _ ->
      {:error, "Empty List"}
    end
  end 


end
