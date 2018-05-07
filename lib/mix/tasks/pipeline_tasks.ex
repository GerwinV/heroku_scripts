defmodule Mix.Tasks.PipelineTasks do
  @shortdoc "Runs a mix task for over a Heroku pipeline "
  @moduledoc """
  This mix task wil run the given mix task on a pipeline of heroku. You can
  run it in the commandline with the app name a stage and the task you want
  to run.

  It is optional to add the options `waiting_time` and `number_of_processes`.
  The waiting time is the time that the task will be given before it gets
  killed. The number of processes determines the amount of processes and connections
  that are opened to Heroku.

  It needs at least 3 arguments to run
  ## Usage

      # These arguments are required
      mix PipelineTasks app_name stage YourTask

      # With extra options
      mix PipelineTasks app_name stage YourTask waiting_time=30000 number_of_processes=2

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

  def run([pipeline, stage, task | args]) do
    if Enum.count(args) > 2 do
      message("#{pipeline} #{stage} #{task}")
    else
      opts =
        Enum.reduce(args, %{}, fn arg, acc ->
          [key, value] = String.split(arg, "=")
          Map.put(acc, key, value)
        end)

      HerokuScripts.run_pipeline_task(pipeline, stage, task, opts)
    end
  end

  def run(_), do: message("pipeline stage task, you've added to many arguments")

  defp message(args) do
    IO.puts("This task needs three arguments the 'pipeline', 'stage' and 'task'.")
    IO.puts("The command can be run with \"mix PipelineTasks #{args}")
  end
end
