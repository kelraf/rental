defmodule RentalWeb.TenantView do
  use RentalWeb, :view
  alias RentalWeb.TenantView

  def render("index.json", %{tenants: tenants}) do
    %{data: render_many(tenants, TenantView, "tenant.json")}
  end

  def render("show.json", %{tenant: tenant}) do
    %{data: render_one(tenant, TenantView, "tenant.json")}
  end
  def render("error.json", %{error: error}) do
    %{data: render_one(error, TenantView, "errors.json")}
  end
  def render("tenant.json", %{tenant: tenant}) do
    %{id: tenant.id,
      email: tenant.email,
      phone: tenant.phone}
  end
    def render("errors.json", %{error: error}) do
    %{error: error}
  end
end
