defmodule HelloWorld.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello_clik,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: HelloClik]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:clik, "~> 0.2.1"}
    ]
  end
end
