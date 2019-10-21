defmodule Art.Components do
  @moduledoc """
  Helper functions for components
  """

  alias Scenic.Primitive
  alias Scenic.Primitive.SceneRef
  alias Scenic.Graph

  alias Art.Component.Pentagram
  alias Art.Component.PentagramFractal

  #-------------------------------------------------------------------------
  @doc """
  Adds a pentagon to a graph
  """
  def pentagon(graph_or_primative, radius, options \\ [])

  def pentagon(%Graph{} = graph, radius, options) do
      add_to_graph(graph, Pentagon, radius, options)
  end

  def pentagon(%Primitive{module: SceneRef} = p, data, options) do
    modify(p, Pentagon, data, options)
  end

 @doc """
  Generate an uninstantiated pentagon spec, parallel to the concept of
  primitive specs. See `Art.Component.Pentagon` for data and options values.
  """
  def pentagon_spec(data, options), do: &pentagon(&1, data, options)


  #-------------------------------------------------------------------------
  @doc """
  Adds a pentagram to a graph
  """
  def pentagram(graph_or_primative, radius, options \\ [])

  def pentagram(%Graph{} = graph, radius, options) do
    add_to_graph(graph, Pentagram, radius, options)
  end

  @doc """
  Generate an uninstantiated pentagram spec, parallel to the concept of
  primitive specs. See `Art.Component.pentagram` for data and options values.
  """
  def pentagram_spec(data, options), do: &pentagram(&1, data, options)

  #-------------------------------------------------------------------------
  @doc """
  Adds a pentagram fractal to a graph
  """
  def pentagram_fractal(graph_or_primative, data, options \\ [])

  def pentagram_fractal(%Graph{} = graph, [radius: radius, depth: depth], options) do
    add_to_graph(graph, PentagramFractal, [radius: radius, depth: depth], options)
  end

  @doc """
  Generate an uninstantiated pentagram fractal spec, parallel to the concept of
  primitive specs. See `Art.Component.pentagram_fractal` for data and options values.
  """
  def pentagram_fractal_spec(data, options), do: &pentagram_fractal(&1, data, options)






  #-------------------------------------------------------------------------
  defp add_to_graph(%Graph{} = g, mod, data, options) do
    mod.verify!(data)
    mod.add_to_graph(g, data, options)
  end

  defp modify(%Primitive{module: SceneRef} = p, mod, data, options) do
    mod.verify!(data)
    Primitive.put(p, {mod, data}, options)
  end
end
