defmodule Art.MixProject do
  use Mix.Project

  def project do
    [
      app: :art,
      version: "0.1.0",
      elixir: "~> 1.9",
      build_embedded: true,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Art, []},
      extra_applications: []
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:scenic, "~> 0.10"},
      {:scenic_driver_glfw, "~> 0.10", targets: :host},
      # {:scenic_live_reload, "~> 0.1", only: :dev},
      # {:micro_timer, "~> 0.1.1"}
    ]
  end
end
