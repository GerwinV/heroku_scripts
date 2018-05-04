# HerokuScripts

A wrapper around the pipelines of Heroku

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `heroku_scripts` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:heroku_scripts, "~> 0.1.0", only: dev}
  ]
end
```

## Usage

Open the iex console with `iex -S mix`, and run:

```ex
HerokuScripts.run_mix_task_over|pipeline("pipeline_name", "your stage", "YourMixTask")
```

where the stage defaults are `"review"`, `"staging"` and `"production"`

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/heroku_scripts](https://hexdocs.pm/heroku_scripts).

