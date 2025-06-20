defmodule Helper.Validator do
  @moduledoc """
  Utility module for validating and sanitizing CSV row maps.
  """

  @doc """
  Removes BOM (Byte Order Mark) from all keys in a map.
  """
  def remove_bom_from_keys(map) when is_map(map) do
    for {k, v} <- map, into: %{} do
      {String.replace(k, "\uFEFF", ""), v}
    end
  end
end
