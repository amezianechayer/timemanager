defmodule ApiTimeManagerWeb.WorkingtimeJSON do
  alias ApiTimeManager.TimeManagement.Workingtime

  @doc """
  Renders a list of workingtimes.
  """
  def index(%{workingtimes: workingtimes}) do
    %{data: for(workingtime <- workingtimes, do: data(workingtime))}
  end

  @doc """
  Renders a single workingtime.
  """
  def show(%{workingtime: workingtime}) do
    %{
      data: data(workingtime)
    }
  end

  @doc """
  Renders an error.
  """
  def error(%{error: error}) do
    %{error: error}
  end

  # This function is called for each workingtime. If it's a valid Workingtime struct, it will render the correct data.
  defp data(%Workingtime{} = workingtime) do
    %{
      id: workingtime.id,
      start: workingtime.start,
      end: workingtime.end,
      user_id: workingtime.user_id
    }
  end
end
