defmodule Art.Scene.Home do
  # use Scenic.Scene
  require Logger

  alias Scenic.Graph
  alias Scenic.ViewPort

  import Art.Components

  @spec handle_continue({:__set_root__, any, any}, any) :: {:noreply, any}
  def handle_continue({:__set_root__, viewport, scene}, state) do
    # ViewPort.set_root(viewport, scene)
    Logger.debug("Home scene set root. viewport: #{inspect(viewport)} scene: #{inspect(scene)}")
    {:noreply, state}
  end

  use Scenic.Scene

  def init(_, opts) do
    viewport = opts[:viewport]
    # get the width and height of the viewport and find its center
    {:ok, %ViewPort.Status{size: {width, height}}} = ViewPort.info(viewport)
    center_x = width/2
    center_y = height/2

    graph =
      Graph.build(clear_color: :black)
       |> pentagram_fractal([radius: 200, depth: 3], stroke: {2, :green}, translate: {center_x, center_y})
      # |> rectangle({width, height})

      {:ok, graph, [push: graph, continue: {:__set_root__, viewport, __MODULE__}]}
      # {:ok, graph, push: graph}
    end

  # @dialyzer {:nowarn_function, {:handle_continue, 2}}
  # @dialyzer {:nowarn_function, [handle_continue: 2]}
  # @dialyzer {:no_match, handle_continue: 2}

  def handle_input(event, _context, state) do
    Logger.info("Received event: #{inspect(event)}")
    Logger.debug(inspect(state))
    {:noreply, state}
  end
end
