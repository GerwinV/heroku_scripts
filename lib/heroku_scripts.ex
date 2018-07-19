defmodule HerokuScripts do
  @moduledoc """
  A wrapper around some heroku cli commands to run tasks on all environments of the heroku pipeline
  """

  @doc """
  Runs the task that's given on the pipeline and the given stage. The name of the pipeline and stage can be found
  at Heroku. The default stages are `"review"`, `"staging"` and `"production"`

  The optional 'waiting_time' argument is the amounds of miliseconds it waits untill
  the task is killed. The waiting_time is set per environment.

  The `number_of_processes` is the amount of tasks you want to run simultaneously,
  keep in mind that each task will open its own connection with Heroku.

  ## Examples

      iex> HerokuScripts.run_pipeline_task("app_name", "production, "GiveRaiseToPeople")
      :ok

  """
  def run_pipeline_task(
        pipeline,
        pipe,
        task,
        opts \\ %{}
      ) do
    waiting_time = Map.get(opts, "waiting_time", "60000") |> String.to_integer()
    number_of_processes = Map.get(opts, "number_of_processes", "3") |> String.to_integer()

    pipeline
    |> environments(pipe)
    |> Enum.chunk_every(number_of_processes)
    |> Enum.reduce(fn environments, _acc ->
      pids =
        Enum.reduce(environments, [], fn environment, pids ->
          [
            Task.async(fn ->
              System.cmd("heroku", ["run", "-a", "#{environment}", "mix", "#{task}"])
            end)
          ] ++ pids
        end)

      for pid <- pids do
        Task.await(pid, waiting_time)
      end
    end)

    :ok
  end

  defp environments(pipeline, pipe) do
    {string, _} = System.cmd("heroku", ["pipelines:info", pipeline])

    string
    |> String.split("\n")
    |> Enum.slice(7, 100_000)
    |> Enum.reduce([], fn x, acc ->
      array = String.split(x, " ")

      if List.last(array) == pipe,
        do: [List.first(array) | acc],
        else: acc
    end)
  end
end
