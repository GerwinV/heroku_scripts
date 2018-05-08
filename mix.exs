defmodule HerokuScripts.MixProject do
  use Mix.Project

  def project do
    [
      app: :heroku_scripts,
      deps: deps(),
      description: description(),
      elixir: "~> 1.6",
      elixirc_paths: ["lib"],
      name: "HerokuScripts",
      package: package(),
      source_url: "https://github.com/defactosoftware/heroku_scripts",
      start_permanent: Mix.env() == :dev,
      version: "0.0.4"
    ]
  end

  defp description do
    """
    A wrapper around the pipelines of Heroku
    """
  end

  defp package do
    [
      name: :heroku_scripts,
      maintainers: ["Marcel Horlings"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/defactosoftware/heroku_scripts"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
