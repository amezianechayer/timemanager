defmodule TimeManagerWeb.TimesheetHTML do
  use TimeManagerWeb, :html

  embed_templates "timesheet_html/*"

  @doc """
  Renders a timesheet form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def timesheet_form(assigns)
end
