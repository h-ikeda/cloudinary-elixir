defmodule Cloudinary.Transformation.Effect.ReplaceColor do
  @moduledoc false
  import Cloudinary.Transformation.Color
  defguardp is_color(color) when is_rgb(color) or is_rgba(color) or is_binary(color)
  defguardp is_tolerance(tolerance) when is_number(tolerance) and tolerance >= 0

  @spec to_url_string(%{
          required(:to_color) => Cloudinary.Transformation.Color.t(),
          optional(:tolerance) => non_neg_integer | float,
          optional(:from_color) => Cloudinary.Transformation.Color.t()
        }) :: String.t()
  def to_url_string(%{to_color: to_color, tolerance: tolerance, from_color: from_color})
      when is_color(to_color) and is_tolerance(tolerance) and is_color(from_color) do
    "replace_color:#{to_color}:#{tolerance}:#{from_color}"
  end

  def to_url_string(%{to_color: to_color, tolerance: tolerance})
      when is_color(to_color) and is_tolerance(tolerance) do
    "replace_color:#{to_color}:#{tolerance}"
  end

  def to_url_string(%{to_color: to_color, from_color: from_color})
      when is_color(to_color) and is_color(from_color) do
    "replace_color:#{to_color}:50:#{from_color}"
  end

  def to_url_string(%{to_color: to_color}) when is_color(to_color) do
    "replace_color:#{to_color}"
  end
end
