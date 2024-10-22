defmodule ApiTimeManager.WorkingTimes do
  import Ecto.Query, warn: false
  alias ApiTimeManager.Repo
  alias ApiTimeManager.WorkingTimes.WorkingTime

  def list_workingtimes do
    Repo.all(WorkingTime)
  end

  def get_working_time!(id), do: Repo.get!(WorkingTime, id)

  def create_working_time(attrs \\ %{}) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()
  end

  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end
end
