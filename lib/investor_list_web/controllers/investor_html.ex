defmodule InvestorListWeb.InvestorHTML do
  use InvestorListWeb, :html

  embed_templates "investor_html/*"

  @doc """
  Renders a investor form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def investor_form(assigns)
end
