defmodule Mix.Tasks.PipelineTasks do
  @moduledoc """
  This mix task wil run the given mix task on a pipeline of heroku. You can
  run it in the commandline as:

      $ mix PipelineTasks app_name stage YourTask

  Without the three arguments it won't run
  """

  use Mix.Task

  @doc false
  def run([pipeline, stage, task]) do
    HerokuScripts.run_pipeline_task(pipeline, stage, task)
  end

  def run([]), do: message("pipeline stage task. You're currently missing all 3 arguements")

  def run([pipeline]),
    do: message("#{pipeline} stage task. You're currently missing two arguements")

  def run([pipeline, stage]),
    do: message("#{pipeline} #{stage} task. You're currently missing 1 arguement")

  def run(_), do: message("pipeline stage task, you've added to much arguments")

  defp message(args) do
    IO.puts("This task needs three arguments the 'pipeline', 'stage' and 'task'.")
    IO.puts("So you can run this with \"mix PipelineTasks #{args}")
  end
end
