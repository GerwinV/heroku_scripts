defmodule HerokuScripts do
  @moduledoc """
  A wrapper around some heroku cli commands to run tasks on all environments of the heroku pipeline
  """

  @doc """
  Runs the task that's given on the pipeline and the given stage. The name of the pipeline and stage can be found
  at Heroku. The default stages are `"review"`, `"staging"` and `"production"`

  ## Examples

      iex> HerokuScripts.run_mix_task_over_pipline("app_name", "production, "GiveRaiseToPeople)

  """
  def run_mix_task_over_pipline(
        pipeline,
        pipe,
        task,
        waiting_time \\ 60000,
        number_of_processes \\ 3
      ) do
    pipeline
    |> environments(pipe)
    |> Enum.chunk_every(waiting_time)
    |> Enum.reduce(fn environments, acc ->
      pids =
        Enum.reduce(environments, [], fn environment, pids ->
          [
            Task.async(fn ->
              System.cmd("heroku", ["run", "-a", "#{environment}", "mix", "#{task}"])
            end)
          ] ++ pids
        end)

      for pid <- pids do
        Task.await(pid, number_of_processes)
      end
    end)
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
