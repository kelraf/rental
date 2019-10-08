defmodule RentalWeb.TenantController do
  use RentalWeb, :controller

  alias Rental.Tenants
  alias Rental.Tenants.Tenant

  action_fallback RentalWeb.FallbackController

  def index(conn, _params) do
    tenants = Tenants.list_tenants()
    render(conn, "index.json", tenants: tenants)
  end

  def create(conn, %{"tenant" => tenant_params}) do

    with {:ok, %Tenant{} = tenant} <- Tenants.create_tenant(tenant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tenant_path(conn, :show, tenant))
      |> render("show.json", tenant: tenant)
    end

    # case Tenants.create_tenant(tenant_params) do
    #   {:ok, tenant} ->
    #     conn
    #     |> put_status(:created)
    #     |> put_resp_header("location", tenant_path(conn, :show, tenant))
    #     |> render("show.json", tenant: tenant)
    
    #   {:error, changeset} -> 
    #     conn 
    #     |> put_status(422) 
    #     |> json(%{error: get_errors(changeset)})
    # end


  end

  defp get_errors(%{errors: errors}) do
    Enum.reduce errors, %{}, fn {key, validations_errors}, accumulator -> 
      Map.put(accumulator, key, elem(validations_errors, 0)) 
    end 
  end

  def show(conn, %{"id" => id}) do
    tenant = Tenants.get_tenant!(id)
    render(conn, "show.json", tenant: tenant)
  end

  def update(conn, %{"id" => id, "tenant" => tenant_params}) do
    tenant = Tenants.get_tenant!(id)

    with {:ok, %Tenant{} = tenant} <- Tenants.update_tenant(tenant, tenant_params) do
      render(conn, "show.json", tenant: tenant)
    end
  end

  def delete(conn, %{"id" => id}) do
    tenant = Tenants.get_tenant!(id)
    with {:ok, %Tenant{}} <- Tenants.delete_tenant(tenant) do
      send_resp(conn, :no_content, "")
    end
  end
end
