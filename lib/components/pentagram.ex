defmodule Art.Component.Pentagram do
  @moduledoc """
  Draws a pentagram
  """
  use Scenic.Component

  require Logger

  alias Scenic.Graph
  alias Scenic.Math.Vector2
  alias Scenic.Math.Matrix

  import Scenic.Primitives

  @angle 4 * :math.pi() / 5.0  # 144 degrees in radians
  @rotation Matrix.rotate(Matrix.identity(),  @angle)

  @vertex0 Vector2.down()
  @vertex1 Vector2.project(@vertex0, @rotation)
  @vertex2 Vector2.project(@vertex1, @rotation)
  @vertex3 Vector2.project(@vertex2, @rotation)
  @vertex4 Vector2.project(@vertex3, @rotation)

  @pentagram_vertices [@vertex0, @vertex1, @vertex2, @vertex3, @vertex4]

  @spec internal_angle :: float
  def internal_angle() do
    @angle
  end

  @spec unit_pentagram_vertices :: [{float, float}, ...]
  def unit_pentagram_vertices() do
    @pentagram_vertices
  end

  @doc false
  def info(data) do
    """
    #{IO.ANSI.red()}#{__MODULE__} data must be a number
    #{IO.ANSI.yellow()}Received: #{inspect(data)}
    #{IO.ANSI.default_color()}
  """
  end

  @doc false
  def verify(radius) when is_number(radius), do: {:ok, radius}
  def verify(_), do: :invalid_data

  def init(radius, opts) do
    scaled_vertices = Enum.map(@pentagram_vertices, fn vector -> Vector2.mul(vector, radius) end)

    graph =
      Graph.build(clear_color: :black)
      |> path(path_elements(scaled_vertices), opts)

    state = %{
      graph: graph,
      radius: radius
    }

    # {:ok, state}
    {:ok, state, [push: graph]}
  end

  defp path_elements([{first_x, first_y} | vertices]) do
    [:begin, {:move_to, first_x, first_y}]
      ++ Enum.map(vertices, fn {x, y} -> {:line_to, x, y} end)
      ++ [:close_path]
  end
end
