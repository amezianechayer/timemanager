defmodule TimeManagerWeb.ClockHTML do
  use TimeManagerWeb, :html

  embed_templates "clock_html/*"

  @doc """
  Renders a clock form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def clock_form(assigns)
end
