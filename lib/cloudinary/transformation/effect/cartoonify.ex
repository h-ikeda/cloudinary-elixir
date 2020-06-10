defmodule Cloudinary.Transformation.Effect.Cartoonify do
  @moduledoc false
  defguardp is_0_to_100(value) when value <= 100 and value >= 0

  @spec to_url_string(%{
          optional(:line_strength) => 0..100 | float,
          optional(:color_reduction) => 0..100 | float | :blackwhite
        }) :: String.t()
  def to_url_string(%{line_strength: line_strength, color_reduction: :blackwhite})
      when is_0_to_100(line_strength) do
    "cartoonify:#{line_strength}:bw"
  end

  def to_url_string(%{color_reduction: :blackwhite}), do: "cartoonify:50:bw"

  def to_url_string(%{line_strength: line_strength, color_reduction: color_reduction})
      when is_0_to_100(line_strength) and is_0_to_100(color_reduction) do
    "cartoonify:#{line_strength}:#{color_reduction}"
  end

  def to_url_string(%{color_reduction: color_reduction}) when is_0_to_100(color_reduction) do
    "cartoonify:50:#{color_reduction}"
  end

  def to_url_string(%{line_strength: line_strength}) when is_0_to_100(line_strength) do
    "cartoonify:#{line_strength}"
  end
end
