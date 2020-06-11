defmodule Cloudinary.Transformation.Effect.Shear do
  @moduledoc false
  @spec to_url_string(%{optional(:x) => number, optional(:y) => number}) :: String.t()
  def to_url_string(%{x: x, y: y}) when is_number(x) and is_number(y), do: "shear:#{x}:#{y}"
  def to_url_string(%{x: x}) when is_number(x), do: "shear:#{x}:0"
  def to_url_string(%{y: y}) when is_number(y), do: "shear:0:#{y}"
end
