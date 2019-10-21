defmodule Art.Component.PentagramFractal do
  @moduledoc """
  Draws a pentagram fractal
  """
  use Scenic.Component, has_children: true

  require Logger

  alias Scenic.Graph
  # alias Scenic.Primitives
  alias Scenic.Math.Vector2

  alias Art.Component.Pentagram
  import Art.Components

  @doc false
  def info(data) do
    """
    #{IO.ANSI.red()}#{__MODULE__} data must be [radius: number, depth: positive_integer]
    #{IO.ANSI.yellow()}Received: #{inspect(data)}
    #{IO.ANSI.default_color()}
  """
  end

  @doc false
  def verify([radius: radius, depth: depth] = params)
    when is_number(radius) and depth > 0, do: {:ok, params}
  def verify(_), do: :invalid_data

  def init([radius: radius, depth: depth], _opts) do
    depth = depth - 1

    graph =
      Graph.build(clear_color: :black)
      |> pentagram(radius)
      |> recurse(radius, depth)

      Logger.debug(~s(PentagramFractal.init radius: #{inspect(radius)} depth: #{inspect(depth)}\n)
        <> inspect(graph)
      )

    state = %{graph: graph, radius: radius, depth: depth}

    {:ok, state, [push: graph]}
  #  {:ok, state}
  end

  def recurse(graph, _radius, 0) do graph end
  def recurse(graph, radius, depth) when depth > 0 do
    vertices = Enum.map(Pentagram.unit_pentagram_vertices(), &Vector2.mul(&1, radius))
    graph = Enum.reduce(vertices, graph, fn vertex, g ->
      pentagram_fractal(g, [radius: radius/4, depth: depth], [translate: vertex, stroke: {2, :blue}])
      end
    )
    # Logger.debug(inspect(graph))
  graph
  end

  # def recurse(graph, radius, depth) when depth > 0 do
  #   vertices = Enum.map(Pentagram.unit_pentagram_vertices(), &Vector2.mul(&1, radius))
  #   fractal_specs = Enum.map(
  #     vertices,
  #     &pentagram_fractal_spec(
  #       [radius: radius/4, depth: depth],
  #       [translate: &1]))

  #   graph = Primitives.add_specs_to_graph(graph, fractal_specs)
  #   Logger.debug(inspect(graph))
  #   graph
  # end
end
