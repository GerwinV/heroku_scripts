# HerokuScripts

A wrapper around the pipelines of Heroku

## Installation

The package can be installed by adding `heroku_scripts` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:heroku_scripts, "~> 0.0.2", only: dev}
  ]
end
```

## Usage

You can run your mix tasks with the following line. Where `pipeline_name` should
be your name of your pipeline in heroku. The stage should be the stage that you want to target (the defaults are `"review"`, `"staging"` and `"production"`). And `YourTask` should be replaced by the mix task you want to run.

```bash
$ mix PipelineTasks pipeline_name stage YourTask
```


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/heroku_scripts](https://hexdocs.pm/heroku_scripts).

